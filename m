From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 24 Feb 2015 19:21:43 +0900
Subject: [PATCH] ARM: dts: Add the source clock for CLKOUT register as
 xusbxti
In-Reply-To: <1424770315-4725-1-git-send-email-ideal.song@samsung.com>
References: <1424770315-4725-1-git-send-email-ideal.song@samsung.com>
Message-ID: <54EC50B7.7050408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inha,

On 02/24/2015 06:31 PM, Inha Song wrote:
> This patch add the CLKOUT register source clock as xusbxti in
> PMU (Power Management Unit) dt node on Exynos3250.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 277b48b..aa1eb8c 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -130,6 +130,9 @@
>  		pmu_system_controller: system-controller at 10020000 {
>  			compatible = "samsung,exynos3250-pmu", "syscon";
>  			reg = <0x10020000 0x4000>;
> +			#clock-cells = <1>;
> +			clock-names = "clkout9";
> +			clocks = <&xusbxti>;
>  		};
>  
>  		mipi_phy: video-phy at 10020710 {
> 

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
