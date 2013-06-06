From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Jun 2013 16:55:51 +0800
Subject: [PATCH 4/4] ARM i.MX53: tqma53: add WP/CD pinctrl and vmmc to
 esdhc2
In-Reply-To: <1370337150-18487-5-git-send-email-s.trumtrar@pengutronix.de>
References: <1370337150-18487-1-git-send-email-s.trumtrar@pengutronix.de>
 <1370337150-18487-5-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20130606085549.GB11305@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 11:12:30AM +0200, Steffen Trumtrar wrote:
> Add WP/CD pinctrl for esdhc2.
> Also, add vmmc-supply for esdhc2.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx53-tqma53.dtsi | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
> index 450e4de..9ecd198 100644
> --- a/arch/arm/boot/dts/imx53-tqma53.dtsi
> +++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
> @@ -35,7 +35,9 @@
>  
>  &esdhc2 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_esdhc2_1>;
> +	pinctrl-0 = <&pinctrl_esdhc2_1>,
> +		    <&pinctrl_esdhc2_2>;
> +	vmmc-supply = <&reg_3p3v>;
>  	wp-gpios = <&gpio1 2 0>;
>  	cd-gpios = <&gpio1 4 0>;
>  	status = "disabled";
> @@ -69,6 +71,15 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
>  
> +	esdhc2_2 {
> +		pinctrl_esdhc2_2: esdhc2-grp2 {

pinctrl_esdhc2_2 should be used by <soc>.dtsi to define the second pin
group for esdhc2 function, so please encode the board name in it to
avoid the name space conflict. 

Shawn

> +			fsl,pins = <
> +				MX53_PAD_GPIO_4__GPIO1_4	0x80000000 /* SD2_CD */
> +				MX53_PAD_GPIO_2__GPIO1_2	0x80000000 /* SD2_WP */
> +			>;
> +		};
> +	};
> +
>  	i2s {
>  		pinctrl_i2s_1: i2s-grp1 {
>  			fsl,pins = <
> -- 
> 1.8.2.rc2
> 
