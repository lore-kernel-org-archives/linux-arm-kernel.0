From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Oct 2015 15:03:34 +0200
Subject: [PATCH 1/7] arm: dts: Add syscon-{reboot, poweroff} nodes for
 exynos3250 SoCs
In-Reply-To: <1445234635-3950-2-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <1445234635-3950-2-git-send-email-alim.akhtar@samsung.com>
Message-ID: <5624EA26.9030909@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/19/2015 08:03 AM, Alim Akhtar wrote:
> This patch adds syscon-{reboot, poweroff} nodes to allow the
> generic syscon-{reboot, poweroff} driver to reset/poweroff exynos3250 SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 033def482fc3..af5d9ad4c7b7 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -152,6 +152,20 @@
>  			interrupt-parent = <&gic>;
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

I don't have a Exynos3250 manual but I guess 0x330C is also named
PS_HOLD_CONTROL and 0x400 is SWRESET as the other Exynos SoCs.

I wonder if a macro could be used instead of magic numbers or at
least have a comment next to the offset field.

The patch looks good to me though and a comment can be added as
a follow up so:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
