From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 16 Jun 2015 00:45:08 +0100
Subject: [PATCH v2] ARM: tegra124: pmu support
In-Reply-To: <1434393968-1105-1-git-send-email-khuey@kylehuey.com>
References: <1434393968-1105-1-git-send-email-khuey@kylehuey.com>
Message-ID: <557F6384.5030207@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15/06/15 19:46, Kyle Huey wrote:
> This patch modifies the device tree for tegra124 based devices to enable the Cortex A15 PMU.  The interrupt numbers are taken from NVIDIA TRM DP-06905-001_v03p.  This patch was tested on a Jetson TK1.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 4be06c6..d966d4e 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -906,16 +906,24 @@
>  
>  		cpu at 3 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <3>;
>  		};
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
>  	thermal-zones {
>  		cpu {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors =
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
>  		};
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Jon
