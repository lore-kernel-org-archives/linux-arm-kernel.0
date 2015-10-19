From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Oct 2015 15:10:07 +0200
Subject: [PATCH 4/7] arm: dts: Add syscon-{reboot, poweroff} nodes for
 exynos5410 SoC
In-Reply-To: <1445234635-3950-5-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <1445234635-3950-5-git-send-email-alim.akhtar@samsung.com>
Message-ID: <5624EBAF.3080506@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/19/2015 08:03 AM, Alim Akhtar wrote:
> This patch adds syscon-{reboot, poweroff} nodes to allow the
> generic syscon-{reboot, poweroff} driver to reset/poweroff exynos5410 SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 731eefd23fa9..b9bef8b5ffc9 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -102,6 +102,20 @@
>  			reg = <0x10040000 0x5000>;
>  		};
>  
> +		poweroff: syscon-poweroff {
> +			compatible = "syscon-poweroff";
> +			regmap = <&pmu_system_controller>;
> +			offset = <0x330C>;
> +			mask = <0x5200>;
> +		};
> +
> +		reboot: syscon-reboot {
> +			compatible = "syscon-reboot";
> +			regmap = <&pmu_system_controller>;
> +			offset = <0x0400>;
> +			mask = <0x1>;
> +		};
> +

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
