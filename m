From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 03 Sep 2013 14:36:58 +1000
Subject: [PATCH] ARM: ep93xx: Don't use modem interface on the second UART
In-Reply-To: <1377786491-15759-1-git-send-email-ynezz@true.cz>
References: <1377786491-15759-1-git-send-email-ynezz@true.cz>
Message-ID: <5225676A.3070803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/13 00:28, Petr ?tetiar wrote:
> Second UART doesn't have modem interface, so any attempt to use set_mctrl() it
> produce unwanted garbage on the line. There's no such 0x100 register offset
> for the second UART either.
> 
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>

Hi Petr,

Sorry for the late reply. Added to ep93xx-fixes.

Thanks,
~Ryan

> ---
>  arch/arm/mach-ep93xx/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index df8612f..3f12b88 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -281,7 +281,7 @@ static AMBA_APB_DEVICE(uart1, "apb:uart1", 0x00041010, EP93XX_UART1_PHYS_BASE,
>  	{ IRQ_EP93XX_UART1 }, &ep93xx_uart_data);
>  
>  static AMBA_APB_DEVICE(uart2, "apb:uart2", 0x00041010, EP93XX_UART2_PHYS_BASE,
> -	{ IRQ_EP93XX_UART2 }, &ep93xx_uart_data);
> +	{ IRQ_EP93XX_UART2 }, NULL);
>  
>  static AMBA_APB_DEVICE(uart3, "apb:uart3", 0x00041010, EP93XX_UART3_PHYS_BASE,
>  	{ IRQ_EP93XX_UART3 }, &ep93xx_uart_data);
> 
