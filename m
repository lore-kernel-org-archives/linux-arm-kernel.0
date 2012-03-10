From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 10 Mar 2012 08:08:17 -0800
Subject: [GIT PULL 1/4] Samsung devel for v3.4
Message-ID: <4F5B7C71.2090303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is various develop regarding Samsung stuff for v3.4.
Please pull following:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung

I think, you can pull this cleanly without any conflicts.
If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

   Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung

Amit Daniel Kachhap (5):
       ARM: EXYNOS: Add support AFTR mode on EXYNOS4210
       ARM: S5P: add L2 early resume code
       ARM: EXYNOS: save L2 settings during bootup
       ARM: EXYNOS: remove useless code to save/restore L2
       ARM: EXYNOS: Enable l2 configuration through device tree

Andrzej Pietrasiewicz (1):
       ARM: EXYNOS: add support JPEG

Changhwan Youn (1):
       ARM: EXYNOS: fix cycle count for periodic mode of clock event timers

Jingoo Han (1):
       ARM: SAMSUNG: Add a callback 'notify_after' for PWM backlight control

Joonyoung Shim (2):
       ARM: S3C64XX: Add usb otg phy control
       ARM: S5PV210: Add usb otg phy control

Kamil Debski (1):
       ARM: SAMSUNG: add G2D to plat-s5p and mach-exynos

Mark Brown (4):
       ARM: S3C64XX: Add basic cpuidle driver
       ARM: S3C64XX: Gate some more clocks by default
       ARM: S3C64XX: Reduce residency requirement for cpuidle WFI mode
       ARM: S3C64XX: Define some additional always off clocks

Minho Ban (1):
       ARM: SAMSUNG: use spin_lock_irqsave() in clk_{enable,disable}

MyungJoo Ham (1):
       ARM: EXYNOS: Add DMC1, allow PPMU access for DMC

Sylwester Nawrocki (1):
       ARM: SAMSUNG: Correct MIPI-CSIS io memory resource definition

Tushar Behera (2):
       ARM: SAMSUNG: Add __init attribute to samsung_bl_set()
       ARM: SAMSUNG: fix __init attribute on regarding s3c_set_platdata()

  arch/arm/mach-exynos/clock.c                       |    5 +
  arch/arm/mach-exynos/common.c                      |   60 ++++++--
  arch/arm/mach-exynos/cpuidle.c                     |  151 
+++++++++++++++++++-
  arch/arm/mach-exynos/include/mach/map.h            |    7 +
  arch/arm/mach-exynos/include/mach/pmu.h            |    2 +
  arch/arm/mach-exynos/mct.c                         |   21 ++-
  arch/arm/mach-exynos/pm.c                          |   15 --
  arch/arm/mach-s3c64xx/Kconfig                      |    8 +
  arch/arm/mach-s3c64xx/Makefile                     |    2 +
  arch/arm/mach-s3c64xx/clock.c                      |  121 ++++++++++++++--
  arch/arm/mach-s3c64xx/cpuidle.c                    |   91 ++++++++++++
  arch/arm/mach-s3c64xx/mach-crag6410.c              |    4 +
  arch/arm/mach-s3c64xx/mach-smartq.c                |    3 +
  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    4 +
  arch/arm/mach-s3c64xx/setup-usb-phy.c              |   90 ++++++++++++
  arch/arm/mach-s5pv210/Kconfig                      |    6 +
  arch/arm/mach-s5pv210/Makefile                     |    1 +
  arch/arm/mach-s5pv210/include/mach/regs-sys.h      |    4 -
  arch/arm/mach-s5pv210/setup-usb-phy.c              |   90 ++++++++++++
  arch/arm/plat-s5p/Kconfig                          |   10 ++
  arch/arm/plat-s5p/sleep.S                          |   44 +++++-
  arch/arm/plat-samsung/clock.c                      |   12 +-
  arch/arm/plat-samsung/dev-backlight.c              |    4 +-
  arch/arm/plat-samsung/devs.c                       |   68 ++++++++-
  arch/arm/plat-samsung/include/plat/devs.h          |    2 +
  .../plat-samsung/include/plat/regs-usb-hsotg-phy.h |    7 +-
  arch/arm/plat-samsung/include/plat/udc-hs.h        |    5 +
  27 files changed, 765 insertions(+), 72 deletions(-)
  create mode 100644 arch/arm/mach-s3c64xx/cpuidle.c
  create mode 100644 arch/arm/mach-s3c64xx/setup-usb-phy.c
  create mode 100644 arch/arm/mach-s5pv210/setup-usb-phy.c
