From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 14:56:26 +0100
Subject: [PATCH 03/11] dt-bindings: clock: add NXP LPC32xx clock list for
 consumers
In-Reply-To: <1447981511-29653-4-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <1447981511-29653-4-git-send-email-vz@mleia.com>
Message-ID: <4268221.QhjAE5RLYk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 03:05:03 Vladimir Zapolskiy wrote:
> +
> +/* LPC32XX System Control Block clocks */
> +#define LPC32XX_CLK_RTC                0
> +#define LPC32XX_CLK_DMA                1
> +#define LPC32XX_CLK_MLC                2
> +#define LPC32XX_CLK_SLC                3
> +#define LPC32XX_CLK_LCD                4
> +#define LPC32XX_CLK_MAC                5
> +#define LPC32XX_CLK_SD         6
> +#define LPC32XX_CLK_DDRAM      7
> +#define LPC32XX_CLK_SSP0       8
> +#define LPC32XX_CLK_SSP1       9
> +#define LPC32XX_CLK_UART3      10
> +#define LPC32XX_CLK_UART4      11
> +#define LPC32XX_CLK_UART5      12
> +#define LPC32XX_CLK_UART6      13
> +#define LPC32XX_CLK_IRDA       14
> +#define LPC32XX_CLK_I2C1       15
> 

Any chance we can avoid the include file? This is going to make it really
hard to merge everything in one merge window with the dependencies between
the driver, the bindings and the platform code.

If there is a way to describe the clocks based on numbers from the
data sheet instead of making up your own, that makes life much
easier for us.

	Arnd
