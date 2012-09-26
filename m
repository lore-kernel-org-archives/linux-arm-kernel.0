From: marex@denx.de (Marek Vasut)
Date: Thu, 27 Sep 2012 01:59:29 +0200
Subject: [PATCH 1/3] ARM: dts: imx53-qsb: Use pinctrl for gpio-led
In-Reply-To: <1348702057-2351-1-git-send-email-festevam@gmail.com>
References: <1348702057-2351-1-git-send-email-festevam@gmail.com>
Message-ID: <201209270159.29809.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 8fe4554f (leds: leds-gpio: adopt pinctrl support) gpio-led
> driver has pinctrl support, so setup the gpio led pin via pinctrl and
> avoid the following warning:
> 
> leds-gpio leds.2: pins are not configured from the driver
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
>  arch/arm/boot/dts/imx53-qsb.dts |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts
> b/arch/arm/boot/dts/imx53-qsb.dts index 08948af..5bae4c7 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -60,10 +60,16 @@
>  							697  0x80000000	/* 
MX53_PAD_EIM_DA12__GPIO3_12 */
>  							701  0x80000000	/* 
MX53_PAD_EIM_DA13__GPIO3_13 */
>  							868  0x80000000	/* 
MX53_PAD_PATA_DA_0__GPIO7_6 */
> +						>;
> +					};
> +
> +					led_pin_gpio7_7: led_gpio7_7 at 0 {
> +						fsl,pins = <
>  							873  0x80000000	/* 
MX53_PAD_PATA_DA_1__GPIO7_7 */
> 
>  						>;
> 
>  					};
>  				};
> +
>  			};
> 
>  			uart1: serial at 53fbc000 {
> @@ -216,6 +222,8 @@
> 
>  	leds {
>  		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pin_gpio7_7>;
> 
>  		user {
>  			label = "Heartbeat";

Best regards,
Marek Vasut
