From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 16:34:41 +0800
Subject: [PATCH 05/18] ARM: dts: vf610: add modules required for PM
In-Reply-To: <1457576219-7971-6-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-6-git-send-email-stefan@agner.ch>
Message-ID: <20160331083441.GY28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 06:16:46PM -0800, Stefan Agner wrote:
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index b038ea4..335f4e5 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -434,6 +434,11 @@
>  				reg = <0x40050000 0x400>;
>  			};
>  
> +			scsc: scsc at 40052000 {
> +				compatible = "fsl,vf610-scsc";

These new compatible strings should be documented somewhere.

Shawn

> +				reg = <0x40052000 0x1000>;
> +			};
> +
>  			usbphy0: usbphy at 40050800 {
>  				compatible = "fsl,vf610-usbphy";
>  				reg = <0x40050800 0x400>;
> @@ -480,6 +485,13 @@
>  				status = "disabled";
>  			};
>  
> +			wakeup: wkpu at 4006a000 {
> +				compatible = "fsl,vf610-wkpu";
> +				reg = <0x4006a000 0x1000>;
> +				interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_WKPU>;
> +			};
> +
>  			clks: ccm at 4006b000 {
>  				compatible = "fsl,vf610-ccm";
>  				reg = <0x4006b000 0x1000>;
> @@ -600,6 +612,13 @@
>  				status = "disabled";
>  			};
>  
> +			ddrmc: ddrmc at 400ae000 {
> +				compatible = "fsl,vf610-ddrmc";
> +				reg = <0x400ae000 0x400>;
> +				clocks = <&clks VF610_CLK_DDRMC>;
> +				clock-names = "ddrc";
> +			};
> +
>  			adc1: adc at 400bb000 {
>  				compatible = "fsl,vf610-adc";
>  				reg = <0x400bb000 0x1000>;
> -- 
> 2.7.2
> 
> 
