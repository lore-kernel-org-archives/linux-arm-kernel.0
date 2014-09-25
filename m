From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Sep 2014 17:46:55 +0900
Subject: [PATCH v3 0/1] ARM: EXYNOS: Fix builds with PM_SLEEP=n
In-Reply-To: <1411568402-24561-1-git-send-email-b.zolnierkie@samsung.com>
References: <1411568402-24561-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5423D67F.5050203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/14 23:20, Bartlomiej Zolnierkiewicz wrote:
> Hi,
>
> This patch fixes builds with CONFIG_PM_SLEEP config option disabled.
> It has been runtime tested on Exynos4210 based Origen board.
>
> Depends on:
> - for-next branch of linux-samsung.git kernel tree
> - [PATCH v7 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with secure
>    firmware enabled
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg37073.html)
>
OK, I'll queue this fixup once the AFTR related changes get ack from 
tegra guy, tegra changes are just trivial though....

Thanks,
Kukjin

> Changes since v2:
> (http://www.mail-archive.com/linux-samsung-soc%40vger.kernel.org/msg35430.html)
> - rebased on top of for-next branch of linux-samsung.git kernel tree +
>    [PATCH v7 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with secure
>    firmware enabled
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg37073.html)
>
> Changes since v1:
> (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34079.html)
> - rebased on top of next-20140811
> - fixed OOPS on the first try to enter cpuidle AFTR mode
>    (config with CONFIG_PM_SLEEP=n and CONFIG_ARM_EXYNOS_CPUIDLE=y)
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>
> Bartlomiej Zolnierkiewicz (1):
>    ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y
>
>   arch/arm/mach-exynos/Kconfig   |   5 +
>   arch/arm/mach-exynos/Makefile  |   5 +-
>   arch/arm/mach-exynos/common.h  |   4 +
>   arch/arm/mach-exynos/pm.c      | 338 +-------------------------------------
>   arch/arm/mach-exynos/suspend.c | 356 +++++++++++++++++++++++++++++++++++++++++
>   arch/arm/plat-samsung/Makefile |   1 +
>   6 files changed, 374 insertions(+), 335 deletions(-)
>   create mode 100644 arch/arm/mach-exynos/suspend.c
>

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
