From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 6 Dec 2016 21:07:56 +0200
Subject: [PATCH 3/5] arm64: dts: exynos5433: Add PPMU dt node
In-Reply-To: <1480663087-4590-4-git-send-email-cw00.choi@samsung.com>
References: <1480663087-4590-1-git-send-email-cw00.choi@samsung.com>
 <1480663087-4590-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <20161206190756.GA12683@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 04:18:05PM +0900, Chanwoo Choi wrote:
> This patch adds PPMU (Platform Performance Monitoring Unit) Device-tree node
> to measure the utilization of each IP in Exynos SoC.
> 
> - PPMU_D{0|1}_CPU are used to measure the utilization of MIF (Memory Interface)
>   block with VDD_MIF power source.
> - PPMU_D{0|1}_GENERAL are used to measure the utilization of INT(Internal)
>   block with VDD_INT power source.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 64226d5ae471..8c4ee84d5232 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -599,6 +599,30 @@
>  			clock-names = "fin_pll", "mct";
>  		};
>  
> +		ppmu_d0_cpu: ppmu at 10480000 {
> +			compatible = "samsung,exynos-ppmu-v2";
> +			reg = <0x10480000 0x2000>;
> +			status = "disabled";

Why these are disabled? They have some external dependencies?

Best regards,
Krzysztof

> +		};
> +
> +		ppmu_d0_general: ppmu at 10490000 {
> +			compatible = "samsung,exynos-ppmu-v2";
> +			reg = <0x10490000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_d1_cpu: ppmu at 104b0000 {
> +			compatible = "samsung,exynos-ppmu-v2";
> +			reg = <0x104b0000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_d1_general: ppmu at 104c0000 {
> +			compatible = "samsung,exynos-ppmu-v2";
> +			reg = <0x104c0000 0x2000>;
> +			status = "disabled";
> +		};
> +
>  		pinctrl_alive: pinctrl at 10580000 {
>  			compatible = "samsung,exynos5433-pinctrl";
>  			reg = <0x10580000 0x1a20>, <0x11090000 0x100>;
> -- 
> 1.9.1
> 
