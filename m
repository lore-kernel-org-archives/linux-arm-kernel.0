From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Mar 2013 14:02:39 +0000
Subject: [GIT PULL] Preparatory GIC patches for arm64 support
Message-ID: <20130328140239.GF24039@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As I'm about to go on holiday for two weeks and I haven't heard any
preference for who should be merging these patches, I'm sending the pull
request to arm-soc given that 90% of the changes target SoC code. Apart
from the gic_secondary_init() patch, the rest is trivial header code
moving around or removal.

Russell, if you have any objections, please let arm-soc guys and me know
and feel free to pull these patches via your tree. I don't mind either
way.

Thanks,

Catalin


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git gic

for you to fetch changes up to c0114709ed85a5693eb74acdfa03d94f7f12e5b8:

  irqchip: gic: Perform the gic_secondary_init() call via CPU notifier (2013-03-26 16:12:02 +0000)

----------------------------------------------------------------
Catalin Marinas (4):
      arm: Move the set_handle_irq and handle_arch_irq declarations to asm/irq.h
      arm: Move chained_irq_(enter|exit) to a generic file
      irqchip: gic: Call handle_bad_irq() directly
      irqchip: gic: Perform the gic_secondary_init() call via CPU notifier

 arch/arm/include/asm/irq.h                  |  5 +++
 arch/arm/include/asm/mach/irq.h             | 36 --------------------
 arch/arm/mach-at91/gpio.c                   |  3 +-
 arch/arm/mach-exynos/common.c               |  1 +
 arch/arm/mach-exynos/platsmp.c              |  8 -----
 arch/arm/mach-highbank/platsmp.c            |  7 ----
 arch/arm/mach-imx/platsmp.c                 | 12 -------
 arch/arm/mach-msm/platsmp.c                 |  8 -----
 arch/arm/mach-omap2/omap-smp.c              |  7 ----
 arch/arm/mach-prima2/platsmp.c              |  8 -----
 arch/arm/mach-s3c24xx/irq.c                 |  1 +
 arch/arm/mach-shmobile/smp-emev2.c          |  7 ----
 arch/arm/mach-shmobile/smp-r8a7779.c        |  7 ----
 arch/arm/mach-shmobile/smp-sh73a0.c         |  7 ----
 arch/arm/mach-socfpga/platsmp.c             | 12 -------
 arch/arm/mach-spear13xx/platsmp.c           |  8 -----
 arch/arm/mach-tegra/platsmp.c               |  8 -----
 arch/arm/mach-ux500/platsmp.c               |  8 -----
 arch/arm/mach-virt/platsmp.c                |  8 -----
 arch/arm/plat-samsung/irq-vic-timer.c       |  3 +-
 arch/arm/plat-samsung/s5p-irq-gpioint.c     |  3 +-
 arch/arm/plat-versatile/platsmp.c           |  8 -----
 drivers/gpio/gpio-msm-v2.c                  |  3 +-
 drivers/gpio/gpio-mxc.c                     |  2 +-
 drivers/gpio/gpio-omap.c                    |  3 +-
 drivers/gpio/gpio-pl061.c                   |  2 +-
 drivers/gpio/gpio-pxa.c                     |  3 +-
 drivers/gpio/gpio-tegra.c                   |  3 +-
 drivers/irqchip/exynos-combiner.c           |  1 +
 drivers/irqchip/irq-gic.c                   | 32 +++++++++++++-----
 drivers/irqchip/irq-vic.c                   |  2 +-
 drivers/pinctrl/pinctrl-at91.c              |  3 +-
 drivers/pinctrl/pinctrl-exynos.c            |  3 +-
 drivers/pinctrl/pinctrl-nomadik.c           |  2 +-
 drivers/pinctrl/pinctrl-sirf.c              |  2 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c      |  2 +-
 drivers/staging/imx-drm/ipu-v3/ipu-common.c |  2 +-
 include/linux/irqchip/arm-gic.h             |  1 -
 include/linux/irqchip/chained_irq.h         | 52 +++++++++++++++++++++++++++++
 39 files changed, 99 insertions(+), 194 deletions(-)
 create mode 100644 include/linux/irqchip/chained_irq.h
