From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 14:30:37 +0200
Subject: [PATCH V3 00/17] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle
In-Reply-To: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <53453D6D.8030903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 08.04.2014 14:19, Daniel Lezcano wrote:
> Changelog:
>
> V3:
> 	* Added patch   : "ARM: exynos: cpuidle: Disable cpuidle for 5440"
> 	* Removed patch : "ARM: exynos: config: Enable cpuidle"
> 	* Removed default ARM_EXYNOS4210_CPUIDLE=y
> 	* Added comment about bug fix side effect 'for_each_possible_cpu'
> V2:
> 	* Added comment in changelog for calls order (5/17)
> 	* Call the powerdown only for cpu0 in the pm notifier
> 	* Set the pm notifier for all boards
>
> V1: initial post
>
> This patchset relies on the cpm_pm notifier to initiate the powerdown sequence
> operations from pm.c instead cpuidle.c. Thus the cpuidle driver is no longer
> dependent from arch specific code as everything is called from the pm.c file.
>
> The patchset applies on top of linux-samsung/for-next.
>
> Tested on exynos4: 4210
> Tested on exynos5: 5250 (without AFTR)
>
> Daniel Lezcano (17):
>    ARM: exynos: cpuidle: Prevent forward declaration
>    ARM: exynos: cpuidle: use cpuidle_register
>    ARM: exynos: cpuidle: change function name prefix
>    ARM: exynos: cpuidle: encapsulate register access inside a function
>    ARM: exynos: cpuidle: Move some code inside the idle_finisher
>    ARM: exynos: cpuidle: Fix S5P_WAKEUP_STAT call
>    ARM: exynos: cpuidle: Use the cpu_pm notifier
>    ARM: exynos: cpuidle: Move scu_enable in the cpu_pm notifier
>    ARM: exynos: cpuidle: Remove ifdef for scu_enable
>    ARM: exynos: cpuidle: Move exynos_set_wakeupmask in the cpu_pm
>      notifier
>    ARM: exynos: cpuidle: Move the power sequence call in the cpu_pm
>      notifier
>    ARM: exynos: cpuidle: Move S5P_CHECK_AFTR in a header
>    ARM: exynos: cpuidle: Move clock setup to pm.c
>    ARM: exynos: cpuidle: Move the boot vector in pm.c
>    ARM: exynos: cpuidle: Disable cpuidle for 5440
>    ARM: exynos: cpuidle: Pass the AFTR callback to the platform_data
>    ARM: exynos: cpuidle: Move the driver to drivers/cpuidle directory
>
>   arch/arm/mach-exynos/Makefile    |    1 -
>   arch/arm/mach-exynos/common.h    |    1 +
>   arch/arm/mach-exynos/cpuidle.c   |  255 --------------------------------------
>   arch/arm/mach-exynos/exynos.c    |    8 +-
>   arch/arm/mach-exynos/pm.c        |  177 +++++++++++++++++++++-----
>   arch/arm/mach-exynos/pmu.c       |    6 +
>   arch/arm/mach-exynos/regs-pmu.h  |   20 +++
>   drivers/cpuidle/Kconfig.arm      |    6 +
>   drivers/cpuidle/Makefile         |    1 +
>   drivers/cpuidle/cpuidle-exynos.c |   97 +++++++++++++++
>   10 files changed, 285 insertions(+), 287 deletions(-)
>   delete mode 100644 arch/arm/mach-exynos/cpuidle.c
>   create mode 100644 drivers/cpuidle/cpuidle-exynos.c
>

For all patches except 10-12, 14 and 16:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
