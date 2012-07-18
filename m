From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 18 Jul 2012 19:15:20 +0530
Subject: [PATCH 0/8] EXYNOS5: USB: Add USB 2.0 and USB 3.0 support for exynos5
Message-ID: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds arch support for USB 2.0(EHCI and OHCI)
and USB 3.0(DWC3) on exynos5.

Below patch modifies few functions to enable supporting
exynos5 later.
EXYNOS4: USB: Generalising setup-usb-phy driver for exynos

Based and tested on 'for-next' branch.

Ajay Kumar (2):
  ARM: EXYNOS5: Add machine data for USB 2.0
  ARM: EXYNOS5: Add OHCI device from device tree

Vivek Gautam (6):
  EXYNOS4: USB: Generalising setup-usb-phy driver for exynos
  ARM: EXYNOS5: Add EHCI device from device tree
  ARM: EXYNOS5: Add PHY initialization code for usb 2.0
  ARM: EXYNOS5: Add machine data for USB3.0
  ARM: EXYNOS5: Add XHCI device from device tree
  ARM: EXYNOS5: Add PHY initialization code for usb 3.0

 .../devicetree/bindings/usb/exynos-usb.txt         |   60 +++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   18 +
 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-exynos/clock-exynos5.c               |   24 ++
 arch/arm/mach-exynos/common.c                      |   10 +
 arch/arm/mach-exynos/include/mach/map.h            |    3 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h       |    4 +
 arch/arm/mach-exynos/include/mach/regs-usb-phy.h   |   86 ++++
 arch/arm/mach-exynos/mach-exynos5-dt.c             |   26 ++
 arch/arm/mach-exynos/setup-usb-phy.c               |  413 ++++++++++++++++++--
 arch/arm/plat-samsung/include/plat/map-s5p.h       |    2 +
 .../include/plat/regs-usb3-exynos-drd-phy.h        |   75 ++++
 arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
 drivers/usb/Kconfig                                |    1 +
 15 files changed, 695 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-usb3-exynos-drd-phy.h
