From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 15 Jun 2015 17:45:33 +0100
Subject: [PATCH] ARM: tegra124: pmu support
In-Reply-To: <1434169283-19512-1-git-send-email-khuey@kylehuey.com>
References: <1434169283-19512-1-git-send-email-khuey@kylehuey.com>
Message-ID: <557F012D.5040509@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-tegra ML ...

On 13/06/15 05:21, Kyle Huey wrote:
> This patch modifies the device tree for tegra124 based devices to enable the Cortex A15 PMU.  The interrupt numbers are taken from NVIDIA TRM DP-06905-001_v03p.  This patch was tested on a Jetson TK1.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 4be06c6..9032ccb 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -190,6 +190,14 @@
>  		status = "disabled";
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	timer at 0,60005000 {
>  		compatible = "nvidia,tegra124-timer", "nvidia,tegra20-timer";
>  		reg = <0x0 0x60005000 0x0 0x400>;
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
