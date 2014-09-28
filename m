From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 28 Sep 2014 12:02:34 +0800
Subject: [PATCH 2/3] ARM: dts: vf610: Add SNVS node
In-Reply-To: <49cb7f5fc8319fc47dc2919a2ccbff981196d4ff.1411736171.git.maitysanchayan@gmail.com>
References: <cover.1411736171.git.maitysanchayan@gmail.com>
 <49cb7f5fc8319fc47dc2919a2ccbff981196d4ff.1411736171.git.maitysanchayan@gmail.com>
Message-ID: <20140928040233.GG12999@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 06:44:00PM +0530, Sanchayan Maity wrote:
> This adds a devicetree node for RTC support
> for the VF610 platform.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 4d2ec32..3c0c757 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -381,6 +381,21 @@
>  					<&clks VF610_CLK_DMAMUX3>;
>  			};
>  
> +			snvs0: snvs at 400a7000 {
> +				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x400a7000 0x2000>;
> +
> +				snvs-rtc-lp at 34 {
> +					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> +					reg = <0x34 0x58>;
> +					interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clks VF610_CLK_SNVS>;
> +					clock-names = "snvs";

The name should describe the clock usage inside the block, so "snvs" is
not a good description.

Shawn

> +				};
> +			};
> +
>  			uart4: serial at 400a9000 {
>  				compatible = "fsl,vf610-lpuart";
>  				reg = <0x400a9000 0x1000>;
> -- 
> 1.7.9.5
> 
