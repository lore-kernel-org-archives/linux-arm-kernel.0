From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 23:30:29 +0200
Subject: [PATCH 1/3] ARM: at91: dt: add header to define at_hdmac
 configuration
In-Reply-To: <1369930103-11963-2-git-send-email-ludovic.desroches@atmel.com>
References: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
 <1369930103-11963-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <201305312330.29364.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 May 2013, ludovic.desroches at atmel.com wrote:
> +/*
> + * Source and/or destination peripheral ID
> + */
> +#define AT91_DMA_CFG_PER_ID_MASK       (0xff)
> +#define AT91_DMA_CFG_PER_ID(id)                (id & AT91_DMA_CFG_PER_ID_MASK)
> +

I'm a little worried about macros like this one spreading in the name
of readability, and I don't see this as actual value-add here:

The output of the macro is always the same as the input, and passing
an invalid number still results in an invalid output and no error message,
it actually prevents us from warning about the mistake at run-time.

The other macros are fine.

	Arnd
