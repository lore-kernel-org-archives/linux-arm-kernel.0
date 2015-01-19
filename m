From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 19 Jan 2015 19:01:40 +0900
Subject: [PATCHv8 7/9] ARM: dts: Add PPMU dt node for Exynos5260 SoC
In-Reply-To: <1421066097-26237-8-git-send-email-cw00.choi@samsung.com>
References: <1421066097-26237-1-git-send-email-cw00.choi@samsung.com>
 <1421066097-26237-8-git-send-email-cw00.choi@samsung.com>
Message-ID: <54BCD604.3030105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

I'll drop this patch because I can't test it on Exynos5260-based board.

Best Regards,
Chanwoo Choi

On 01/12/2015 09:34 PM, Chanwoo Choi wrote:
> This patch adds PPMU (Performance Profiling Monitoring Unit) dt node
> Exynos5260 SoC.
> 
> Exynos5260 SoC has following PPMU IPs:
> - PPMU_DREX0_S0 0x10c60000
> - PPMU_DREX0_S1 0x10c70000
> - PPMU_DREX1_S0 0x10c80000
> - PPMU_DREX1_S1 0x10c90000
> - PPMU_EAGLE    0x10cc0000
> - PPMU_KFC      0x10cd0000
> - PPMU_MFC      0x11040000
> - PPMU_G3D      0x11880000
> - PPMU_FSYS     0x12220000
> - PPMU_ISP      0x13370000
> - PPMU_FICM     0x13cb0000
> - PPMU_GSCL     0x13e60000
> - PPMU_MSCL     0x13ee0000
> - PPMU_FIMD0X   0x145b0000
> - PPMU_FIMD1X   0x145c0000
> 
> The drivers/devfreq/exynos/exynos5_bus.c supports the memory bus frequency/
> voltage scaling of Exynos5260 SoC with DEVFREQ framework.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> Cc: Jonghwan Choi <jhbird.choi@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5260.dtsi | 90 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
> index 36da38e..26f3074 100644
> --- a/arch/arm/boot/dts/exynos5260.dtsi
> +++ b/arch/arm/boot/dts/exynos5260.dtsi
> @@ -307,6 +307,96 @@
>  			fifo-depth = <64>;
>  			status = "disabled";
>  		};
> +
> +		ppmu_drex0_s0: ppmu_drex0_s0 at 10c60000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10c60000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_drex0_s1: ppmu_drex0_s1 at 10c70000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10c70000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_drex1_s0: ppmu_drex1_s0 at 10c80000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10c80000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_drex1_s1: ppmu_drex1_s1 at 10c90000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10c90000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_eagle: ppmu_eagle at 10cc0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10cc0000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_kfc: ppmu_kfc at 10cd0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10cd0000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_mfc: ppmu_mfc at 11040000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x11040000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_g3d: ppmu_g3d at 11880000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x11880000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_fsys: ppmu_fsys at 12220000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x12220000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_isp: ppmu_isp at 13370000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x13370000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_fimc: ppmu_fimc at 13cb0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x13cb0000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_gscl: ppmu_gscl at 13e60000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x13e60000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_mscl: ppmu_gscl at 13ee0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x13ee0000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_fimd0x: ppmu_fimd0x at 145b0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x145b0000 0x2000>;
> +			status = "disabled";
> +		};
> +
> +		ppmu_fimd1x: ppmu_fimd1x at 145c0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x145c0000 0x2000>;
> +			status = "disabled";
> +		};
>  	};
>  };
>  
> 
