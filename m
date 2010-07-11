From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sun, 11 Jul 2010 21:05:58 +0400
Subject: SAM9-L9260: TXD1 is not working on AT91SAM9260
In-Reply-To: <4C381CCF.2050305@gmail.com>
References: <4C381CCF.2050305@gmail.com>
Message-ID: <20100711210558.75ce662f@realm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

> In my board file (arch/arm/mach-at91/board-sam9-l9260.c) I added the
> following line to ek_map_io(), to register USART1 as ttyS2:
> 
> -----------------------------------------------------------------------
> at91_register_uart(AT91SAM9260_ID_US1, 2, 0);
> -----------------------------------------------------------------------

You modify here default configuration which is 
	at91_register_uart(AT91SAM9260_ID_US1, 2, 
		ATMEL_UART_CTS | ATMEL_UART_RTS);

Do you turn off hardware handshake when you configure 
your test setup for ttyS2 ?

Thanks,
Sergey
