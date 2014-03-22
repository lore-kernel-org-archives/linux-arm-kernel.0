From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 22 Mar 2014 14:46:54 +0800
Subject: [PATCH 4/5] ARM: dts: tx53: add simple-panel support
In-Reply-To: <1395235721-13847-4-git-send-email-LW@KARO-electronics.de>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
 <1395235721-13847-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140322064653.GC5938@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 02:28:40PM +0100, Lothar Wa?mann wrote:
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx53-tx53-x13x.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> index 26b918e..86a964d 100644
> --- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
> +++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> @@ -63,6 +63,18 @@
>  		default-brightness-level = <50>;
>  	};
>  
> +	panel0 {
> +		compatible = "simple-panel";

>From what I can see, "simple-panel" is not a documented compatible.

Shawn

> +		power-supply = <&reg_lcd_pwr0>;
> +		backlight = <&backlight0>;
> +	};
> +
> +	panel1 {
> +		compatible = "simple-panel";
> +		power-supply = <&reg_lcd_pwr1>;
> +		backlight = <&backlight1>;
> +	};
> +
>  	regulators {
>  		reg_lcd_pwr0: regulator at 5 {
>  			compatible = "regulator-fixed";
> -- 
> 1.7.10.4
> 
> 
> 
