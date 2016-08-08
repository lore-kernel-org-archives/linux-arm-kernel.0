From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 8 Aug 2016 16:09:24 +0100
Subject: [PATCH 4/6] ARM: tegra: Add Tegra30 GMI support
In-Reply-To: <1470512452-8322-5-git-send-email-mirza.krak@gmail.com>
References: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
 <1470512452-8322-5-git-send-email-mirza.krak@gmail.com>
Message-ID: <ca971719-f73f-fc22-5b39-57d2636b55a1@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/08/16 20:40, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Add a device node for the GMI controller found on Tegra30.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 5030065..5fd4d29 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -439,6 +439,16 @@
>  		status = "disabled";
>  	};
>  
> +	gmi at 70009000 {
> +		compatible = "nvidia,tegra30-gmi";
> +		reg = <0x70009000 0x1000>;
> +		clocks = <&tegra_car TEGRA30_CLK_NOR>;
> +		clock-names = "gmi";
> +		resets = <&tegra_car 42>;
> +		reset-names = "gmi";
> +		status = "disabled";

#address-cells, #size-cells and ranges appears to be missing.

Cheers
Jon

-- 
nvpublic
