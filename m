From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 31 Oct 2013 13:15:40 +0530
Subject: [PATCH RFC 0/4] Add Exynos5 USB 3.0 phy driver based on generic PHY
 framework
Message-ID: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a phy driver for USB 3.0 PHY controller present on Exynos5
series of SoCs alongwith DWC3 controller for USB 3.0 operations.

This driver is inline with Kamil's USB 2.0 phy driver. [1]
Few functions used to translate ref clock rate are common to
Kamil's changes. So we can figure out how to re-use them across
these drivers.

Theses patches are based on usb-next branch and tested with
Kishon's patches for adapting DWC3 to generic phy framework, [2]
on smdk5250 as well as smdk5420 board.

[1] [PATCH 0/5] phy: Add new Exynos USB PHY driver
    https://lkml.org/lkml/2013/10/25/230
[2] [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform indicates the presence of PHY's
    (http://www.spinics.net/lists/linux-usb/msg95733.html)
    [PATCH v2 2/7] usb: dwc3: adapt dwc3 core to use Generic PHY Framework
    (http://www.spinics.net/lists/linux-usb/msg95734.html)

Vivek Gautam (4):
  phy: Add new Exynos5 USB 3.0 PHY driver
  dt: exynos5250: Enable support for generic USB 3.0 phy
  dt: exynos5420: Enable support for USB 3.0 PHY controller
  dt: exynos5420: Enable support for DWC3 controller

 .../devicetree/bindings/phy/samsung-phy.txt        |   20 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   17 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   50 ++
 drivers/phy/Kconfig                                |    7 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-exynos5-usb3.c                     |  562 ++++++++++++++++++++
 6 files changed, 646 insertions(+), 11 deletions(-)
 create mode 100644 drivers/phy/phy-exynos5-usb3.c

-- 
1.7.6.5
