From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 19 Mar 2015 14:11:48 +0900
Subject: [PATCH v4 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
 Exynos3250
In-Reply-To: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
References: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <550A5A94.2080207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

I tested this patch-set for AFTR mode.
When CPU1 is offline state, I checked that CPU0 enter the AFTR mode.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

On 03/19/2015 01:00 AM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds support for AFTR idle mode on boards with
> Exynos3250 SoC and allows EXYNOS cpuidle driver usage on these
> boards.
> 
> It has been tested on Samsung Rinato board (Gear 2).
> 
> Depends on:
> - for-next branch (commit: 77105c882ba6) of linux-samsung.git
>   kernel tree
> 
> Changes since v3:
> - enhanced patch description for patch #1
> - added Reviewed-by/Tested-by tags from Krzysztof
> - enhanced C2_STATE BOOT mode flag comment
> - moved exynos_{set,clear}_boot_flag() to firmware.c
> - added patch description to patch #3
> 
> Changes since v2:
> - rebased on top of for-next branch (commit: 77105c882ba6) of
>   linux-samsung.git kernel tree
> 
> Changes since v1:
> - rebased on top of for-next branch (commit: ce275c369a0b) of
>   linux-samsung.git kernel tree
> - fixed lockup on hotplug by using dsb_sev() instead of IPI in
>   exynos_boot_secondary() on Exynos3250
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (4):
>   ARM: EXYNOS: fix CPU1 hotplug on Exynos3250
>   ARM: EXYNOS: add code for setting/clearing boot flag
>   ARM: EXYNOS: cpuidle: add AFTR mode support for Exynos3250
>   ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250 SoC
> 
>  arch/arm/mach-exynos/common.h   |  6 ++++++
>  arch/arm/mach-exynos/exynos.c   |  1 +
>  arch/arm/mach-exynos/firmware.c | 33 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-exynos/platsmp.c  | 23 ++++++++++++++++++++---
>  arch/arm/mach-exynos/pm.c       | 12 +++++++++++-
>  arch/arm/mach-exynos/regs-pmu.h |  3 +++
>  arch/arm/mach-exynos/smc.h      |  9 +++++++++
>  7 files changed, 82 insertions(+), 5 deletions(-)
> 
