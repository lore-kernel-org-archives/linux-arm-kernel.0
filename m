From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 03 Apr 2013 11:02:53 +0900
Subject: [PATCH 0/2] These two patches to s3c_pm_arch_prepare_irqs() were
 part of the work
In-Reply-To: <1363711900-25560-1-git-send-email-dianders@chromium.org>
References: <1363711900-25560-1-git-send-email-dianders@chromium.org>
Message-ID: <24b401ce300f$5a767b40$0f6371c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote:
> 
> to make suspend/resume reliable on the ARM Chromebook
> (exynos5250-snow).
> 
> A few more details:
> - The first patch is not strictly needed but was a nice cleanup.  Our
>   understanding was that EINT0 was originally turned on for exynos
>   evt0 silicon and not needed for evt1.

Looks good to me, applied, thanks.

> - The second patch is more important and (also) more obvious.  The
>   function was modifying the S5P_WAKEUP_MASK register and then
>   clobbering its own modifications.
> 
Applied with 1st one, BTW, do you want to send this for stable tree?

- Kukjin

> For some history, see:
> - https://gerrit.chromium.org/gerrit/31337
> - https://gerrit.chromium.org/gerrit/31341
> 
> 
> Jonathan Kliegman (2):
>   arm: exynos: Remove hardcode wakeup unmask for EINT_0
>   arm: exynos: Clear ENABLE_WAKEUP_SW bit when entering suspend
> 
>  arch/arm/mach-exynos/include/mach/pm-core.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> --
> 1.8.1.3
