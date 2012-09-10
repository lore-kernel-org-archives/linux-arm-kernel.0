From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Sep 2012 10:23:46 +0800
Subject: [PATCH 7/7] ARM: dts: cfa10049: Add the 74HC595 gpio expanders
In-Reply-To: <1347020296-18796-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347020296-18796-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120910022342.GR26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 02:18:16PM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Empty commit message is never a good start.

> ---
>  arch/arm/boot/dts/imx28-cfa10049.dts |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> index 1f7fa50..05c892e 100644
> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -27,6 +27,8 @@
>  					fsl,pinmux-ids = <
>  						0x0181 /* MX28_PAD_GPMI_RDN__SSP3_SCK */
>  						0x01c1 /* MX28_PAD_GPMI_RESETN__SSP3_CMD */
> +						0x0111 /* MX28_PAD_GPMI_CE1N__SSP3_D3 */
> +						0x01a2 /* MX28_PAD_GPMI_ALE__SSP3_D4 */

What are these two pins used for?

Regards,
Shawn

>  					>;
>  					fsl,drive-strength = <1>;
>  					fsl,voltage = <1>;
> @@ -39,6 +41,25 @@
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&spi3_pins_cfa10049>;
>  				status = "okay";
> +
> +				gpio5: gpio5 at 0 {
> +					compatible = "fairchild,74hc595";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					reg = <0>;
> +					registers-number = <2>;
> +					spi-max-frequency = <100000>;
> +				};
> +
> +				gpio6: gpio6 at 1 {
> +					compatible = "fairchild,74hc595";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					reg = <1>;
> +					registers-number = <4>;
> +					spi-max-frequency = <100000>;
> +				};
> +
>  			};
>  		};
>  
> -- 
> 1.7.9.5
> 
