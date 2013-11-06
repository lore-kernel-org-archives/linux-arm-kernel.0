From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Nov 2013 11:35:15 +0800
Subject: [PATCH] ARM: dts: voipac: Improve fixed voltage regulator
 definition
In-Reply-To: <1383655760-28206-1-git-send-email-lisovy@gmail.com>
References: <1383655760-28206-1-git-send-email-lisovy@gmail.com>
Message-ID: <20131106033514.GQ19770@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 01:49:20PM +0100, Rostislav Lisovy wrote:
> Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
> ---
>  arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
> index a7d03ad..4f1d8fa 100644
> --- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
> +++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
> @@ -27,9 +27,12 @@
>  
>  	regulators {
>  		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
> -		reg_3p3v: 3p3v {
> +		reg_3p3v: regulator at 0 {

Yeah, instead of using arbitrary node name, the generic regulator at num is
more preferable. I will make this change to the rest of IMX dts files.

Applied, thanks.

Shawn

>  			compatible = "regulator-fixed";
> +			reg = <0>;
>  			regulator-name = "3P3V";
>  			regulator-min-microvolt = <3300000>;
>  			regulator-max-microvolt = <3300000>;
> -- 
> 1.7.10.4
> 
