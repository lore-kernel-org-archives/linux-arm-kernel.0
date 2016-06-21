From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 21 Jun 2016 07:28:58 +0300
Subject: [PATCH] clk: lpc32xx: allow peripheral clock selection in device
 tree
In-Reply-To: <1464982475-24738-1-git-send-email-slemieux.tyco@gmail.com>
References: <1464982475-24738-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <f8778993-a393-f72a-ba76-76550a9c5bbd@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 03.06.2016 22:34, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> This patch add the support to select the peripheral clock (PERIPH)
> as a parent clock source using the "assigned-clock-parents"
> parameter in the device tree.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

The change looks good, is it done to support a selection of PWM parent clocks?

I think it makes sense to set PERIPH clock as a default parent for both
PWM controllers, please consider to send a DTS change.


Best wishes,
Vladimir

> ---
>  drivers/clk/nxp/clk-lpc32xx.c             | 3 +--
>  include/dt-bindings/clock/lpc32xx-clock.h | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> index 481b264..90d740a 100644
> --- a/drivers/clk/nxp/clk-lpc32xx.c
> +++ b/drivers/clk/nxp/clk-lpc32xx.c
> @@ -87,7 +87,7 @@ enum {
>  
>  enum {
>  	/* Start from the last defined clock in dt bindings */
> -	LPC32XX_CLK_ADC_DIV = LPC32XX_CLK_HCLK_PLL + 1,
> +	LPC32XX_CLK_ADC_DIV = LPC32XX_CLK_PERIPH + 1,
>  	LPC32XX_CLK_ADC_RTC,
>  	LPC32XX_CLK_TEST1,
>  	LPC32XX_CLK_TEST2,
> @@ -99,7 +99,6 @@ enum {
>  	LPC32XX_CLK_HCLK_DIV_PERIPH,
>  	LPC32XX_CLK_HCLK_DIV,
>  	LPC32XX_CLK_HCLK,
> -	LPC32XX_CLK_PERIPH,
>  	LPC32XX_CLK_ARM,
>  	LPC32XX_CLK_ARM_VFP,
>  
> diff --git a/include/dt-bindings/clock/lpc32xx-clock.h b/include/dt-bindings/clock/lpc32xx-clock.h
> index d41b6fe..e624d3a 100644
> --- a/include/dt-bindings/clock/lpc32xx-clock.h
> +++ b/include/dt-bindings/clock/lpc32xx-clock.h
> @@ -48,6 +48,7 @@
>  #define LPC32XX_CLK_PWM2	33
>  #define LPC32XX_CLK_ADC		34
>  #define LPC32XX_CLK_HCLK_PLL	35
> +#define LPC32XX_CLK_PERIPH	36
>  
>  /* LPC32XX USB clocks */
>  #define LPC32XX_USB_CLK_I2C	1
> 
