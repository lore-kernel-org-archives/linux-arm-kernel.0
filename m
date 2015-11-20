From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 20 Nov 2015 15:49:10 +0900
Subject: [PATCH v3 5/5] ARM: exynos: select POWER_RESET_SYSCON and
 POWER_RESET_SYSCON_POWEROFF
In-Reply-To: <1447996629-18232-6-git-send-email-alim.akhtar@samsung.com>
References: <1447996629-18232-1-git-send-email-alim.akhtar@samsung.com>
 <1447996629-18232-6-git-send-email-alim.akhtar@samsung.com>
Message-ID: <564EC266.5020706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.2015 14:17, Alim Akhtar wrote:
> Since we switch to use generic syscon regmap based reset/poweroff
> driver for exynos SoC, lets select it from ARCH_EXYNOS instead of
> enabling it from various defconfigs. This also select POWER_RESET
> as SYSCON-{reset, poweroff} drivers depends on it.
> 
> Also because of the above changes we don't need special handling
> for reboot/poweroff in exynos pmu driver. This patch also removes
> the same from exynos pmu driver to keep git bisect working.
> 
> Note: This will break reboot/poweroff on boards with older dtbs
> with a newer kernel.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    3 +++
>  arch/arm/mach-exynos/pmu.c   |   43 ------------------------------------------
>  2 files changed, 3 insertions(+), 43 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Thanks, applied with different title:
"ARM: EXYNOS: Switch to syscon reboot and poweroff"
https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/soc

I'll be pushing this to Kukjin for v4.5 (unless he picks it by himself).

Best regards,
Krzysztof
