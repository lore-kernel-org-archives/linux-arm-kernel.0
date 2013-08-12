From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Aug 2013 19:05:26 +0800
Subject: [PATCH 1/3] ARM: dts: mxs: set dcp to "disabled" by default
In-Reply-To: <1375968629-10091-2-git-send-email-LW@KARO-electronics.de>
References: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
 <1375968629-10091-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <20130812110523.GD25292@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 03:30:27PM +0200, Lothar Wa?mann wrote:
> Reintroduce 'status = "disabled"' for the dcp node that was dropped by
> commit 519d8b1a "Added support for Freescale's DCP co-processor".

For IP blocks that do not have pins to be routed on boards, it should be
fine to have it enabled in <soc>.dtsi.

Shawn

> 
> Explicitly enable it in imx28-evk which is referenced in the commit
> message of that commit.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx28-evk.dts |    4 ++++
>  arch/arm/boot/dts/imx28.dtsi    |    3 ++-
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
> index dff2279..ac790bb 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -361,3 +361,7 @@
>  		default-brightness-level = <6>;
>  	};
>  };
> +
> +&dcp {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index e459d63..ea99d09 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -794,9 +794,10 @@
>  			};
>  
>  			dcp: dcp at 80028000 {
> +				compatible = "fsl-dcp";
>  				reg = <0x80028000 0x2000>;
>  				interrupts = <52 53 54>;
> -				compatible = "fsl-dcp";
> +				status = "disabled";
>  			};
>  
>  			pxp: pxp at 8002a000 {
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
