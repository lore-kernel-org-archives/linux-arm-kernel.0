From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 7 Mar 2017 09:48:29 +0000
Subject: [PATCH 01/11] arm64: tegra: Add PMC controller on Tegra186
In-Reply-To: <20170223173053.19701-1-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
Message-ID: <e78806d4-f704-8a71-6686-2ca226473e0e@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23/02/17 17:30, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 62fa85ae0271..d6955bb46ae0 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -307,6 +307,15 @@
>  		#interrupt-cells = <2>;
>  	};
>  
> +	pmc at c360000 {
> +		compatible = "nvidia,tegra186-pmc";
> +		reg = <0 0x0c360000 0 0x10000>,
> +		      <0 0x0c370000 0 0x10000>,
> +		      <0 0x0c380000 0 0x10000>,
> +		      <0 0x0c390000 0 0x10000>;
> +		reg-names = "pmc", "wake", "aotag", "scratch";
> +	};
> +
>  	sysram at 30000000 {
>  		compatible = "nvidia,tegra186-sysram", "mmio-sram";
>  		reg = <0x0 0x30000000 0x0 0x50000>;
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
