From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 8 Mar 2017 12:11:46 +0000
Subject: [PATCH 11/11] arm64: tegra: Add GPIO expanders on P2771
In-Reply-To: <20170223173053.19701-11-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
 <20170223173053.19701-11-thierry.reding@gmail.com>
Message-ID: <915fd5f3-503e-0844-9058-46e1995c50b0@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23/02/17 17:30, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The P2771 development board expands the number of GPIOs via two I2C
> chips.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> index 9485841e3351..eac75764bf3c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> @@ -18,6 +18,28 @@
>  			compatible = "ti,ina3221";
>  			reg = <0x43>;
>  		};
> +
> +		exp1: gpio at 74 {
> +			compatible = "ti,tca9539";
> +			reg = <0x74>;
> +
> +			interrupt-parent = <&gpio>;
> +			interrupts = <TEGRA_MAIN_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
> +
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
> +
> +		exp2: gpio at 77 {
> +			compatible = "ti,tca9539";
> +			reg = <0x77>;
> +
> +			interrupt-parent = <&gpio>;
> +			interrupts = <TEGRA_MAIN_GPIO(Y, 6) GPIO_ACTIVE_LOW>;
> +
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
>  	};
>  
>  	gpio-keys {
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
