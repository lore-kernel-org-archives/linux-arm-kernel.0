From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 8 Mar 2017 12:06:31 +0000
Subject: [PATCH 10/11] arm64: tegra: Add power monitors on P2771
In-Reply-To: <20170223173053.19701-10-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
 <20170223173053.19701-10-thierry.reding@gmail.com>
Message-ID: <cf553179-11e8-680a-cff0-b52c3a598d56@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23/02/17 17:30, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The P2771 development board comes with two power monitors that can be
> used to determine power consumption in different parts of the board.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> index 1c195d71806d..9485841e3351 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> @@ -8,6 +8,18 @@
>  	model = "NVIDIA Tegra186 P2771-0000 Development Board";
>  	compatible = "nvidia,p2771-0000", "nvidia,tegra186";
>  
> +	i2c at 3160000 {
> +		power-monitor at 42 {
> +			compatible = "ti,ina3221";
> +			reg = <0x42>;
> +		};
> +
> +		power-monitor at 43 {
> +			compatible = "ti,ina3221";
> +			reg = <0x43>;
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
