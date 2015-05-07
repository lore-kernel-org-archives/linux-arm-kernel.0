From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 7 May 2015 18:14:43 +0900
Subject: [PATCH] serial: xuartps: add __init to earlycon write method
In-Reply-To: <5630573.8B6nn9XCXJ@wuerfel>
References: <1430989359-4364-1-git-send-email-yamada.masahiro@socionext.com>
 <5630573.8B6nn9XCXJ@wuerfel>
Message-ID: <CAK7LNATxom6m-sP_hx19qVy8waTZ=-ypGSz64pZ0QHRw9=mDjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-05-07 18:08 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 07 May 2015 18:02:39 Masahiro Yamada wrote:
>> @@ -1075,7 +1075,8 @@ static void cdns_uart_console_putchar(struct uart_port *port, int ch)
>>         writel(ch, port->membase + CDNS_UART_FIFO_OFFSET);
>>  }
>>
>> -static void cdns_early_write(struct console *con, const char *s, unsigned n)
>> +static void __init cdns_early_write(struct console *con, const char *s,
>> +                                   unsigned n)
>>  {
>>         struct earlycon_device *dev = con->data;
>>
>>
>
> Why?
>

I thought this function is used during the early boot stage.

I am seeing drivers/tty/serial/8250/8250_early.c
for reference.

All the functions in this file are marked as __init.

Perhaps, am I misunderstanding?



-- 
Best Regards
Masahiro Yamada
