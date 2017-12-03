From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Sun, 3 Dec 2017 22:48:22 +0000
Subject: [PATCH 08/12] ARM: dts: imx6qdl-apalis: Remove unneeded reg
 property
In-Reply-To: <1512156285-18451-8-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-8-git-send-email-festevam@gmail.com>
Message-ID: <1512341301.21715.1.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Fabio for catching that one!

On Fri, 2017-12-01 at 17:24 -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As described in
> Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> there is no 'reg' property under stmpe_touchscreen, so remove it
> to fix the following build warning with W=1:
> 
> arch/arm/boot/dts/imx6q-apalis-eval.dtb: Warning
> (unit_address_vs_reg): Node /soc/aips-bus at 2100000/i2c at 21a4000/stmpe81
> 1 at 41/stmpe_touchscreen has a reg or ranges property, but no unit name
> 
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index e80fdca..4e776e0 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -338,7 +338,6 @@
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			reg = <0>;
>  			/* 3.25 MHz ADC clock speed */
>  			st,adc-freq = <1>;
>  			/* 8 sample average control */
