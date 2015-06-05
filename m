From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 06 Jun 2015 03:05:43 +0900
Subject: [GIT PULL 5/5] Samsung mach updates for v4.2
Message-ID: <5571E4F7.40706@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is Samsung mach updates for v4.2 and this is based on v4.1-rc4
because of dependencies with previous Samsung fixes during -rc

Please pull and if any problems, please let me know.

Thanks,
Kukjin


The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-mach-1

for you to fetch changes up to 2be2a3ff42a52e926cbd1cc1d376a161a9a73667:

  ARM: EXYNOS: register power domain driver from core_initcall
(2015-06-06 02:18:03 +0900)

----------------------------------------------------------------
Samsung updates for v4.2

- add failure(exception) handling
  : of_iomap(), of_find_device_by_node() and kstrdup()

- add common poweroff to use PS_HOLD based for all of exynos SoCs
- add exnos_get/set_boot_addr() helper
- constify platform_device_id and irq_domain_ops
- get current parent clock for power domain on/off
- use core_initcall to register power domain driver
- make exynos_core_restart() less verbose

- add support coupled CPUidle for exynos3250

- fix exynos_boot_secondary() return value on timeout
- fix clk_enable() in s3c24xx adc
- fix missing of_node_put() for power domains

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (5):
      ARM: EXYNOS: fix exynos_boot_secondary() return value on timeout
      ARM: EXYNOS: make exynos_core_restart() less verbose
      ARM: EXYNOS: add exynos_set_boot_addr() helper
      ARM: EXYNOS: add exynos_get_boot_addr() helper
      ARM: EXYNOS: add coupled cpuidle support for Exynos3250

Krzysztof Kozlowski (6):
      ARM: EXYNOS: Handle of of_iomap() failure
      ARM: EXYNOS: Handle of_find_device_by_node() and kstrdup() failures
      ARM: EXYNOS: Add missing of_node_put() when parsing power domains
      ARM: EXYNOS: Get current parent clock for power domain on/off
      ARM: EXYNOS: Constify irq_domain_ops
      ARM: SAMSUNG: Constify platform_device_id

Marek Szyprowski (2):
      ARM: EXYNOS: use PS_HOLD based poweroff for all supported SoCs
      ARM: EXYNOS: register power domain driver from core_initcall

Sergiy Kibrik (1):
      ARM: SAMSUNG: fix clk_enable() WARNing in S3C24XX ADC

 .../bindings/arm/exynos/power_domain.txt           |  7 +-
 arch/arm/include/asm/firmware.h                    |  4 +
 arch/arm/mach-exynos/common.h                      |  4 +-
 arch/arm/mach-exynos/exynos.c                      |  3 +-
 arch/arm/mach-exynos/firmware.c                    | 18 +++++
 arch/arm/mach-exynos/platsmp.c                     | 86
+++++++++++++++-------
 arch/arm/mach-exynos/pm.c                          | 51 +++++++++++--
 arch/arm/mach-exynos/pm_domains.c                  | 53 ++++++++-----
 arch/arm/mach-exynos/pmu.c                         |  6 +-
 arch/arm/mach-exynos/suspend.c                     |  2 +-
 arch/arm/plat-samsung/adc.c                        |  6 +-
 11 files changed, 173 insertions(+), 67 deletions(-)
