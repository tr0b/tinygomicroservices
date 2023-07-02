# base go image

FROM golang:1.20.5-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN go get github.com/go-chi/chi/v5
RUN go get github.com/go-chi/chi/v5/middleware

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

RUN chmod +x /app/brokerApp

# build a tiny docker image

FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app


CMD ["/app/brokerApp"]
