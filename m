From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 17:46:42 +0200
Subject: [PATCH 1/5] arm: dts: mt7623: add a performance counter unit
 device node
In-Reply-To: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
Message-ID: <8376f683-68d2-32b8-c299-32a143dcf2de@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/09/2018 12:22, Ryder Lee wrote:
> Add ARM PMU device node to enable hardware perf events.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to v4.19-next/dts32

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 1cdc346..8c43bd0 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -121,6 +121,15 @@
>  		};
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 6 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
>  	system_clk: dummy13m {
>  		compatible = "fixed-clock";
>  		clock-frequency = <13000000>;
> 
