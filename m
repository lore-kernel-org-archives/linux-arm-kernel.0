From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 8 Aug 2016 16:09:17 +0100
Subject: [PATCH 5/6] ARM: tegra: Add Tegra20 GMI support
In-Reply-To: <1470512452-8322-6-git-send-email-mirza.krak@gmail.com>
References: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
 <1470512452-8322-6-git-send-email-mirza.krak@gmail.com>
Message-ID: <af24f4d2-b8bf-993a-13f3-54dade1ebeb7@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/08/16 20:40, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Add a device node for the GMI controller found on Tegra20.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 2207c08..9b97863 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -376,6 +376,17 @@
>  		status = "disabled";
>  	};
>  
> +
> +	gmi at 70009000 {
> +		compatible = "nvidia,tegra20-gmi";
> +		reg = <70009000 0x1000>;
> +		clocks = <&tegra_car TEGRA20_CLK_NOR>;
> +		clock-names = "gmi";
> +		resets = < &tegra_car 42>;
> +		reset-names = "gmi";
> +		status = "disabled";
> +	};

#address-cells, #size-cells and ranges appears to be missing.

Cheers
Jon

-- 
nvpublic
