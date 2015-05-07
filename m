From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 May 2015 11:08:31 +0200
Subject: [PATCH] serial: xuartps: add __init to earlycon write method
In-Reply-To: <1430989359-4364-1-git-send-email-yamada.masahiro@socionext.com>
References: <1430989359-4364-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <5630573.8B6nn9XCXJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 May 2015 18:02:39 Masahiro Yamada wrote:
> @@ -1075,7 +1075,8 @@ static void cdns_uart_console_putchar(struct uart_port *port, int ch)
>         writel(ch, port->membase + CDNS_UART_FIFO_OFFSET);
>  }
>  
> -static void cdns_early_write(struct console *con, const char *s, unsigned n)
> +static void __init cdns_early_write(struct console *con, const char *s,
> +                                   unsigned n)
>  {
>         struct earlycon_device *dev = con->data;
>  
> 

Why?

	Arnd
