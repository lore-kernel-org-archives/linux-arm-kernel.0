From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Jul 2013 16:45:18 +0800
Subject: [PATCH] ARM: dts: imx25: Make lcdc compatible to imx27/imx21 fb
In-Reply-To: <1373614495-21717-1-git-send-email-weisserm@arcor.de>
References: <1373614495-21717-1-git-send-email-weisserm@arcor.de>
Message-ID: <20130712084516.GI25501@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 09:34:54AM +0200, Matthias Weisser wrote:
> ARM: dts: imx25: Make lcdc compatible to imx27/imx21 fb
> 
> Signed-off-by: Matthias Weisser <weisserm@arcor.de>
> ---
>  arch/arm/boot/dts/imx25.dtsi |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index d2550e0..83532b6 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -377,7 +377,8 @@
>  				status = "disabled";
>  			};
>  
> -			lcdc at 53fbc000 {
> +			lcdc: lcdc at 53fbc000 {
> +				compatible = "fsl,imx27-fb", "fsl,imx21-fb";

It makes more sense to have it be:

	compatible = "fsl,imx25-fb", "fsl,imx21-fb";

Shawn

>  				reg = <0x53fbc000 0x4000>;
>  				interrupts = <39>;
>  				clocks = <&clks 103>, <&clks 66>, <&clks 49>;
> -- 
> 1.7.9.5
> 
