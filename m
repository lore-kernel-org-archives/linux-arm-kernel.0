From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 9 Jun 2014 10:15:36 +0800
Subject: [PATCH] ARM: dts: imx6: add missing compatible and clock
 properties for kpp
In-Reply-To: <1402052579-22803-1-git-send-email-LW@KARO-electronics.de>
References: <1402052579-22803-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140609021535.GX8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 01:02:59PM +0200, Lothar Wa?mann wrote:
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Shawn

> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ce05991..3266d01 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -466,8 +466,10 @@
>  			};
>  
>  			kpp: kpp at 020b8000 {
> +				compatible = "fsl,imx6q-kpp", "fsl,imx21-kpp";
>  				reg = <0x020b8000 0x4000>;
>  				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks 62>; /* IPG clock */
>  			};
>  
>  			wdog1: wdog at 020bc000 {
> -- 
> 1.7.10.4
> 
