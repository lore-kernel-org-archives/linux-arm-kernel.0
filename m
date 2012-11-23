From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 23 Nov 2012 18:02:29 +0530
Subject: [PATCH v9 0/3] ARM: Exynos/S3C64XX: usb phy driver support for S3C64XX
 and EXYNOS4210
Message-ID: <1353673952-13537-1-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables usb phy driver for S3C64XX and EXYNOS4210.
The phy driver patches are already sent to linux-usb.

Changes From v8:
Switched the patch order; removing old phy setup code after enabling
phy driver for s3c64xx machines.
added usb phy platdata structure in arch/arm/mach-s3c64xx/setup-usb-phy.c
and used it for all the boards.

Changes From v7:
Resolved build errors with s3c6400_defconfig, s5pv210_defconfig and
exynos_defconfig.
Tested with all other samsung configs as well.
Reformed PATCH 3 (PATCH 5 of last series) with proper subject.
Separated these arch patches from the driver patches.

Changes from v4:
Changed the platform data code to use __initdata

Changes from v2:
Changed 's3c' to 'samsung' for platform device as well as platform data
Moved platform data structure to a separate file

Praveen Paneri (3):
  ARM: S3C64XX: Enabling samsung-usbphy driver
  ARM: S3C64XX: Removing old phy setup code
  ARM: EXYNOS: Enabling samsung-usbphy driver for EXYNOS4210

 arch/arm/Kconfig                             |    1 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts    |    5 ++
 arch/arm/mach-exynos/Kconfig                 |    1 +
 arch/arm/mach-exynos/include/mach/map.h      |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c       |    8 +++
 arch/arm/mach-exynos/setup-usb-phy.c         |   13 ++++
 arch/arm/mach-s3c64xx/include/mach/map.h     |    2 +
 arch/arm/mach-s3c64xx/mach-crag6410.c        |    6 +-
 arch/arm/mach-s3c64xx/mach-smartq.c          |    6 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c        |    6 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c        |   83 ++++----------------------
 arch/arm/plat-samsung/Kconfig                |    5 ++
 arch/arm/plat-samsung/devs.c                 |   26 ++++++++
 arch/arm/plat-samsung/include/plat/devs.h    |    1 +
 arch/arm/plat-samsung/include/plat/usb-phy.h |    3 +
 15 files changed, 88 insertions(+), 79 deletions(-)
