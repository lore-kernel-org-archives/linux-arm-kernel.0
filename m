From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 Mar 2015 15:21:58 +0100
Subject: [GIT PULL] Exynos changes for v4.1
Message-ID: <1426083718.24734.16.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

This groups non-critical fixes and enhancements for Exynos suspend
and power domain code for upcoming v4.1 release:
1. Add 'const' and 'static' keywords where they are applicable.
2. Remove unused field in struct 'exynos_pm_data'.
3. Be more verbose about power domain name.
4. Handle of_iomap() and of_find_device_by_node() failures.
5. Enable cpuidle in exynos_defconfig.

All of these patches were sent previously to the LKML. I grouped
them so they won't be forgotten. I hope you will find useful
such grouping of pending patches in a pull request.

Best regards,
Krzysztof

----------------------------------------------------------------

The following changes since commit c1b57bce36a69f3972a1db433d3c8b34e0541e63:

  ARM: EXYNOS: cpuidle: Fix build breakage on !SMP (2015-03-11 13:02:08 +0100)

are available in the git repository at:

  git://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.0-rc1-exynos-next

for you to fetch changes up to 150be89d6dddc61a7c01b2678e8872ac73ca68d3:

  ARM: exynos_defconfig: Enable CPU idle (2015-03-11 13:45:26 +0100)

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      ARM: EXYNOS: Add missing static to file-scope declarations
      ARM: EXYNOS: Constify exynos_pm_data array
      ARM: EXYNOS: Remove left over 'extra_save'
      ARM: EXYNOS: Use platform device name as power domain name
      ARM: EXYNOS: Handle of of_iomap() failure
      ARM: EXYNOS: Handle of_find_device_by_node and kstrdup failures
      ARM: exynos_defconfig: Enable CPU idle

 arch/arm/configs/exynos_defconfig |  2 ++
 arch/arm/mach-exynos/pm_domains.c | 21 ++++++++++++++++++++-
 arch/arm/mach-exynos/suspend.c    | 22 ++++++----------------
 3 files changed, 28 insertions(+), 17 deletions(-)
