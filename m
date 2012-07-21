From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 21 Jul 2012 16:02:01 +0530
Subject: [PATCH 0/8 v2] EXYNOS5: USB: Add USB 2.0 and USB 3.0 support for
 exynos5
Message-ID: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v1:
EXYNOS4: USB: Generalising setup-usb-phy driver for exynos
1) Make function exynos_usb_clock_enable() as static.
2) Remove the check for 'usb_clk' in exynos_usb_clock_enable().

ARM: EXYNOS5: Add PHY initialization code for usb 2.0
1) Set HOST_CTRL0_COMMONON_N and reset OTG_SYS_COMMON_ON bits
for host and otg power saving in suspend mode.

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
 arch/arm/mach-exynos/setup-usb-phy.c               |  411 ++++++++++++++++++--
 arch/arm/plat-samsung/include/plat/map-s5p.h       |    2 +
 .../include/plat/regs-usb3-exynos-drd-phy.h        |   75 ++++
 arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
 drivers/usb/Kconfig                                |    1 +
 15 files changed, 693 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-usb3-exynos-drd-phy.h
