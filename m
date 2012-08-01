From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 01 Aug 2012 18:35:46 +0530
Subject: [PATCH 0/5] usb: phy: samsung: Introducing usb phy driver for samsung
 SoCs
Message-ID: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces a phy driver for samsung SoCs. It uses the existing
transceiver infrastructure to provide phy control functions. Use of this driver
can be extended for usb host phy as well. Over the period of time all the phy
related code for most of the samsung SoCs can be integrated here.
Removing the existing phy code from mach-s3c64xx but not from other machine 
code.This driver is tested with smdk6410 and Exynos4210(with DT).

Praveen Paneri (5):
  usb: phy: samsung: Introducing usb phy driver for hsotg
  usb: s3c-hsotg: Adding phy driver support
  ARM: S3C64XX: Removing old phy setup code
  ARM: S3C64XX: Enabling sec_usbphy driver
  ARM: Exynos4210: Enabling sec_usbphy driver

 .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
 arch/arm/boot/dts/exynos4210.dtsi                  |    5 +
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c             |    8 +
 arch/arm/mach-exynos/setup-usb-phy.c               |   13 +
 arch/arm/mach-s3c64xx/include/mach/map.h           |    2 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    5 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |    6 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    5 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c              |   79 +----
 arch/arm/plat-samsung/devs.c                       |   32 ++
 arch/arm/plat-samsung/include/plat/devs.h          |    1 +
 arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
 drivers/usb/gadget/s3c-hsotg.c                     |   38 ++-
 drivers/usb/phy/Kconfig                            |    8 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/sec_usbphy.c                       |  354 ++++++++++++++++++++
 drivers/usb/phy/sec_usbphy.h                       |   48 +++
 include/linux/platform_data/s3c-hsotg.h            |    5 +
 19 files changed, 533 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung-usbphy.txt
 create mode 100644 drivers/usb/phy/sec_usbphy.c
 create mode 100644 drivers/usb/phy/sec_usbphy.h
