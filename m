From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 2 Jul 2015 15:36:49 +0200
Subject: [PATCH v3 2/4] tty/serial: at91: fix some macro definitions to
 fit coding style
In-Reply-To: <11308515.NsBzDiA1lH@wuerfel>
References: <cover.1435672649.git.cyrille.pitchen@atmel.com>
 <9f0f19d2fe05ea95572b467ec49ecd11389e3be9.1435672649.git.cyrille.pitchen@atmel.com>
 <11308515.NsBzDiA1lH@wuerfel>
Message-ID: <55953E71.4070109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I've just sent a new series of patches to remove all those macros.
By the way, the patch dedicated to this update was created using coccinelle.
Based on Alexandre comment, I leave __raw_writel() and __raw_readl() for now.

Best Regards,

Cyrille

Le 30/06/2015 22:28, Arnd Bergmann a ?crit :
> On Tuesday 30 June 2015 16:05:15 Cyrille Pitchen wrote:
>> +#define UART_PUT_CR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_CR)
>> +#define UART_GET_MR(port)      __raw_readl((port)->membase + ATMEL_US_MR)
>> +#define UART_PUT_MR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_MR)
>> +#define UART_PUT_IER(port, v)  __raw_writel(v, (port)->membase + ATMEL_US_IER)
>>
> 
> How about removing these macros entirely? I'm not aware of other drivers
> doing it like this, and it does not seem to add any value?
> 
> At the same time, you could use readl_relaxed() to make the driver
> endian-safe.
> 
> 	Arnd
> 
