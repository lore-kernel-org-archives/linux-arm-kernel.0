From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 09:05:39 +0200
Subject: [PATCH v3 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong
 information of ldo23 and ldo25
In-Reply-To: <1483675149-32598-2-git-send-email-jcsing.lee@samsung.com>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035913epcas5p20336406863f1029ccf614520f366ddcf@epcas5p2.samsung.com>
 <1483675149-32598-2-git-send-email-jcsing.lee@samsung.com>
Message-ID: <20170106070539.wd3kfhi77pa5ekcy@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 12:59:05PM +0900, Jaechul Lee wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch fixes the wrong information of ldo23 and ldo25 on both TM2 and TM2E.

Please describe what is exactly wrong and how it affects the
system/user. This is going to the fixes so it needs a good explanation.

> 
> Fixes: 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts  |  7 ++++---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 10 ----------
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index 3b5215c..e8971f4 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -504,9 +504,9 @@
>  			};
>  
>  			ldo23_reg: LDO23 {
> -				regulator-name = "CAM_SEN_CORE_1.2V_AP";
> +				regulator-name = "CAM_SEN_CORE_1.05V_AP";
>  				regulator-min-microvolt = <1050000>;
> -				regulator-max-microvolt = <1200000>;
> +				regulator-max-microvolt = <1050000>;
>  			};
>  
>  			ldo24_reg: LDO24 {
> @@ -516,9 +516,10 @@
>  			};
>  
>  			ldo25_reg: LDO25 {
> -				regulator-name = "CAM_SEN_A2.8V_AP";
> +				regulator-name = "UNUSED_LDO25";
>  				regulator-min-microvolt = <2800000>;
>  				regulator-max-microvolt = <2800000>;
> +				regulator-always-off;

Don't add it. See my other patch.

Best regards,
Krzysztof

>  			};
>  
>  			ldo26_reg: LDO26 {
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> index 1db4e7f..854c583 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> @@ -18,16 +18,6 @@
>  	compatible = "samsung,tm2e", "samsung,exynos5433";
>  };
>  
> -&ldo23_reg {
> -	regulator-name = "CAM_SEN_CORE_1.025V_AP";
> -	regulator-max-microvolt = <1050000>;
> -};
> -
> -&ldo25_reg {
> -	regulator-name = "UNUSED_LDO25";
> -	regulator-always-off;
> -};
> -
>  &ldo31_reg {
>  	regulator-name = "TSP_VDD_1.8V_AP";
>  	regulator-min-microvolt = <1800000>;
> -- 
> 2.7.4
> 
