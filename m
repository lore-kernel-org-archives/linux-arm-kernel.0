From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Mar 2015 20:14:31 +0800
Subject: [PATCH 1/2] ARM: dts: hummingboard: enable PCF8523 RTC support
In-Reply-To: <E1YSWZG-0002As-7I@rmk-PC.arm.linux.org.uk>
References: <E1YSWZG-0002As-7I@rmk-PC.arm.linux.org.uk>
Message-ID: <20150324121430.GH28410@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 08:03:54PM +0000, Russell King wrote:
> Enable the commented out PCF8523 RTC support for Hummingboard pro
> base boards.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> For acks please.

Russell,

What do you mean by "For acks please"?  Not for apply?  I'm asking if I
should pick up the patches.

Shawn

> 
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> index 674cb237298f..93588c987d2c 100644
> --- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> @@ -113,16 +113,13 @@
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hummingboard_i2c1>;
> -
> -	/*
> -	 * Not fitted on Carrier-1 board... yet
>  	status = "okay";
>  
> +	/* Pro baseboard model */
>  	rtc: pcf8523 at 68 {
>  		compatible = "nxp,pcf8523";
>  		reg = <0x68>;
>  	};
> -	 */
>  };
>  
>  &i2c2 {
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
