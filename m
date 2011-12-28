From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 28 Dec 2011 16:03:19 +0900
Subject: [PATCH 0/6] arch part update of s3c-hsotg driver
Message-ID: <4EFABF37.9020804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset is to use s3c-hsotg driver on EXYNOS4210. To do that, it
is moved to platform data callback functions to control S3C64XX specific
registers of s3c-hsotg driver. Also, adds regulator support to the
s3c-hsotg driver. These are tested only on NURI board having EXYNOS4210.

The base of this patchset is for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

Thanks.

Joonyoung Shim (6):
       ARM: S3C64XX: Add usb otg phy control
       ARM: SAMSUNG: Fix memory size for hsotg
       ARM: EXYNOS: Add usb otg phy control for EXYNOS4210
       ARM: EXYNOS: Add hsotg device for NURI board
       USB: s3c-hsotg: Add platform data callbacks for phy control
       USB: s3c-hsotg: Add regulator support

  arch/arm/mach-exynos/Kconfig                       |    1 +
  arch/arm/mach-exynos/include/mach/irqs.h           |    2 +-
  arch/arm/mach-exynos/include/mach/map.h            |    4 +
  arch/arm/mach-exynos/include/mach/regs-pmu.h       |    3 +
  arch/arm/mach-exynos/mach-nuri.c                   |    9 +-
  arch/arm/mach-exynos/setup-usb-phy.c               |   95 +++++++++---
  arch/arm/mach-s3c64xx/Kconfig                      |    8 +
  arch/arm/mach-s3c64xx/Makefile                     |    1 +
  arch/arm/mach-s3c64xx/mach-crag6410.c              |    4 +
  arch/arm/mach-s3c64xx/mach-smartq.c                |    3 +
  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    4 +
  arch/arm/mach-s3c64xx/setup-usb-phy.c              |   90 +++++++++++
  arch/arm/plat-samsung/devs.c                       |   16 ++-
  .../plat-samsung/include/plat/regs-usb-hsotg-phy.h |    7 +-
  arch/arm/plat-samsung/include/plat/udc-hs.h        |    5 +
  drivers/usb/gadget/s3c-hsotg.c                     |  158 
++++++++++----------
  16 files changed, 299 insertions(+), 111 deletions(-)
  create mode 100644 arch/arm/mach-s3c64xx/setup-usb-phy.c
