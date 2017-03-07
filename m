From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 7 Mar 2017 10:25:47 +0000
Subject: [PATCH 03/11] arm64: tegra: Invert the PMC interrupt on P3310
In-Reply-To: <20170223173053.19701-3-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
 <20170223173053.19701-3-thierry.reding@gmail.com>
Message-ID: <214e3858-ba5d-8489-21dd-26e2bd28940c@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23/02/17 17:30, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The PMC interrupt is inverted on P3310, so mark it as such in the device
> tree to avoid a flood of interrupts when the PMIC is enabled.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index 1abe2eceb3d1..3653d0dd5f4f 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -26,6 +26,10 @@
>  		status = "okay";
>  	};
>  
> +	pmc at c360000 {
> +		nvidia,invert-interrupt;
> +	};
> +

It is probably over-kill to register the pmc as an irq-controller just
to set the 'type' and then hook up the pmic interrupt to the pmc and not
directly gic. So ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
