From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 Jan 2016 16:31:48 -0800
Subject: [PATCH 3/3] ARM: dts: vf610: add remaining SAI instaces
In-Reply-To: <1445141122-14183-3-git-send-email-stefan@agner.ch>
References: <1445141122-14183-1-git-send-email-stefan@agner.ch>
 <1445141122-14183-3-git-send-email-stefan@agner.ch>
Message-ID: <7c3b0b28706f2bf1cf656c7dc2daf31d@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

The rest of the patchset has been applied during rc phase of v4.4, I
guess this one was scheduled for the next release (v4.5). However, I
just realized that this seemed to have slipped through...

--
Stefan

On 2015-10-17 21:05, Stefan Agner wrote:
> This adds the remaining SAI instances SAI0, SAI1 and SAI3. All
> instances are very similar, except that the DMA channel of SAI3
> is available on MUX1 (compared to MUX0 for SAI0-SAI2). Also,
> SAI3 has a slightly different memory map due to a deeper FIFO,
> however in practice the current driver works for SAI3 fine.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index c2a4d1c..b45bc81 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -174,6 +174,34 @@
>  				status = "disabled";
>  			};
>  
> +			sai0: sai at 4002f000 {
> +				compatible = "fsl,vf610-sai";
> +				reg = <0x4002f000 0x1000>;
> +				interrupts = <84 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_SAI0>,
> +					<&clks VF610_CLK_SAI0_DIV>,
> +					<&clks 0>, <&clks 0>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dma-names = "tx", "rx";
> +				dmas = <&edma0 0 17>,
> +					<&edma0 0 16>;
> +				status = "disabled";
> +			};
> +
> +			sai1: sai at 40030000 {
> +				compatible = "fsl,vf610-sai";
> +				reg = <0x40030000 0x1000>;
> +				interrupts = <85 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_SAI1>,
> +					<&clks VF610_CLK_SAI1_DIV>,
> +					<&clks 0>, <&clks 0>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dma-names = "tx", "rx";
> +				dmas = <&edma0 0 19>,
> +					<&edma0 0 18>;
> +				status = "disabled";
> +			};
> +
>  			sai2: sai at 40031000 {
>  				compatible = "fsl,vf610-sai";
>  				reg = <0x40031000 0x1000>;
> @@ -188,6 +216,20 @@
>  				status = "disabled";
>  			};
>  
> +			sai3: sai at 40032000 {
> +				compatible = "fsl,vf610-sai";
> +				reg = <0x40032000 0x1000>;
> +				interrupts = <87 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_SAI3>,
> +					<&clks VF610_CLK_SAI3_DIV>,
> +					<&clks 0>, <&clks 0>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dma-names = "tx", "rx";
> +				dmas = <&edma0 1 9>,
> +					<&edma0 1 8>;
> +				status = "disabled";
> +			};
> +
>  			pit: pit at 40037000 {
>  				compatible = "fsl,vf610-pit";
>  				reg = <0x40037000 0x1000>;
