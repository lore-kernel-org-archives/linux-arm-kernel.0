From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 05 Jan 2015 21:57:41 +0900
Subject: [PATCH RESEND] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <1420215089-2093-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1420215089-2093-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <047c01d028e7$311858e0$93490aa0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Many Exynos devices have a display panel. Most of them just have
> a simple panel while others have more complex configurations that
> requires an embedded DisplayPort (eDP) to LVDS bridges.
> 
> This patch enables the following features to be built in the kernel
> image to support both setups:
> 
> - Direct Rendering Manager (DRM)
> - DRM bridge registration and lookup framework
> - Parade ps8622/ps8625 eDP/LVDS bridge
> - NXP ptn3460 eDP/LVDS bridge
> - Exynos Fully Interactive Mobile Display controller (FIMD)
> - Panel registration and lookup framework
> - Simple panels
> - Backlight & LCD device support
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> 
> Hello Kukjin,
> 
Hi Javier,

Happy new year :)

> You dropped this patch since exynos drm was causing boot hangs on some
> platforms but the fix for that issue is already in linux-next (commit:
> f1e9203 clk: samsung: Fix Exynos 5420 pinctrl setup and clock disable
> failure due to domain being gated) so I think it makes sense to enable
> the display options again.
> 
> NOTE: Display panel is still not working since patch "arm: dts: Exynos5:
> Use pmu_system_controller phandle for dp phy" is needed [0] but I think
> we should enable display options to catch the regressions easier.
> 
Agreed with your suggestion and I'll pick this up into Samsung tree soon.

Thanks,
Kukjin
