From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 08 Aug 2012 13:10:56 +0530
Subject: [PATCH v3 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
Message-ID: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v2:
Changed the driver filenames to samsung-usbphy
Changed 's3c' to 'samsung' for platform device as well as platform data
Moved platform data structure to a separate file
Rectified coding style related errors

Changes from v1:
Rebased patches to latest usb-next branch
Changed the name 'sec_usbphy' to 'samsung_usbphy'

This patch set introduces a phy driver for samsung SoCs. It uses the existing
transceiver infrastructure to provide phy control functions. Use of this driver
can be extended for usb host phy as well. Over the period of time all the phy
related code for most of the samsung SoCs can be integrated here.
Removing the existing phy code from mach-s3c64xx. Same can be done for other SoCs
when they start supporting this phy driver. 
This driver is tested with smdk6410 and Exynos4210(with DT).

Praveen Paneri (5):
  usb: phy: samsung: Introducing usb phy driver for hsotg
  usb: s3c-hsotg: Adding phy driver support
  ARM: S3C64XX: Removing old phy setup code
  ARM: S3C64XX: Enabling samsung-usbphy driver
  ARM: Exynos4210: Enabling samsung-usbphy driver

 .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
 arch/arm/boot/dts/exynos4210.dtsi                  |    5 +
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c             |    8 +
 arch/arm/mach-exynos/setup-usb-phy.c               |   13 +
 arch/arm/mach-s3c64xx/include/mach/map.h           |    2 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    7 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |    8 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    7 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c              |   79 +----
 arch/arm/plat-samsung/devs.c                       |   33 ++
 arch/arm/plat-samsung/include/plat/devs.h          |    1 +
 arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
 drivers/usb/gadget/s3c-hsotg.c                     |   40 ++-
 drivers/usb/phy/Kconfig                            |    8 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/samsung-usbphy.c                   |  355 ++++++++++++++++++++
 drivers/usb/phy/samsung-usbphy.h                   |   48 +++
 include/linux/platform_data/samsung-usbphy.h       |   27 ++
 19 files changed, 562 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung-usbphy.txt
 create mode 100644 drivers/usb/phy/samsung-usbphy.c
 create mode 100644 drivers/usb/phy/samsung-usbphy.h
 create mode 100644 include/linux/platform_data/samsung-usbphy.h
