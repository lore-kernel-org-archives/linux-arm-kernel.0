From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Jun 2015 22:28:42 +0200
Subject: [PATCH v3 2/4] tty/serial: at91: fix some macro definitions to
 fit coding style
In-Reply-To: <9f0f19d2fe05ea95572b467ec49ecd11389e3be9.1435672649.git.cyrille.pitchen@atmel.com>
References: <cover.1435672649.git.cyrille.pitchen@atmel.com>
 <9f0f19d2fe05ea95572b467ec49ecd11389e3be9.1435672649.git.cyrille.pitchen@atmel.com>
Message-ID: <11308515.NsBzDiA1lH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 June 2015 16:05:15 Cyrille Pitchen wrote:
> +#define UART_PUT_CR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_CR)
> +#define UART_GET_MR(port)      __raw_readl((port)->membase + ATMEL_US_MR)
> +#define UART_PUT_MR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_MR)
> +#define UART_PUT_IER(port, v)  __raw_writel(v, (port)->membase + ATMEL_US_IER)
> 

How about removing these macros entirely? I'm not aware of other drivers
doing it like this, and it does not seem to add any value?

At the same time, you could use readl_relaxed() to make the driver
endian-safe.

	Arnd
