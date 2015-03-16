From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Mar 2015 16:17:04 +0800
Subject: [PATCH 1/2] ARM: dts: imx6sl: Add label snvs_rtc
In-Reply-To: <1426348068-17745-1-git-send-email-festevam@gmail.com>
References: <1426348068-17745-1-git-send-email-festevam@gmail.com>
Message-ID: <20150316081702.GN20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 12:47:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> It may be useful to disable the internal snvs-rtc when an external rtc is
> available. This patch adds a label so that dts files can disable it.
> 
> Based on a patch from Markus Pargmann for imx6qdl.dtsi.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

A second thought - it might be useful for some out-of-tree board
support.  Applied, both.

Shawn

> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index ea682e3..a78e715 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -569,7 +569,7 @@
>  				#size-cells = <1>;
>  				ranges = <0 0x020cc000 0x4000>;
>  
> -				snvs-rtc-lp at 34 {
> +				snvs_rtc: snvs-rtc-lp at 34 {
>  					compatible = "fsl,sec-v4.0-mon-rtc-lp";
>  					reg = <0x34 0x58>;
>  					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 1.9.1
> 
