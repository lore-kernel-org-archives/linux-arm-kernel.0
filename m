From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 10 Nov 2016 13:37:30 +0000
Subject: [PATCH] arm64: dts: Add ARM PMU node for exynos7
In-Reply-To: <1478748643-3081-1-git-send-email-alim.akhtar@samsung.com>
References: <1478748643-3081-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <4922ada9-2eb2-f0cf-e4b1-a74f4397f97c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alim,

On 10/11/16 03:30, Alim Akhtar wrote:
> This patch adds ARM Performance Monitor Unit dt node for exynos7.
> PMU provides various statistics on the operation of the CPU and
> memory system at runtime, which are very useful when debugging or
> profiling code. This enables the same.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index e0d0d01..53ce4be 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -472,6 +472,14 @@
>  			status = "disabled";
>  		};
>  
> +		arm-pmu {
> +			compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
> +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;

Per Documentation/devicetree/bindings/arm/pmu.txt there should also be
an "interrupt-affinity" property describing which SPI belongs to which core.

Robin.

> +		};
> +
>  		timer {
>  			compatible = "arm,armv8-timer";
>  			interrupts = <GIC_PPI 13
> 
