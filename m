From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 15:09:03 +0200
Subject: [PATCH 0/8] USB support for DRA7-evm
Message-ID: <1394197751-28984-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series enables the 2 USB ports on the DRA7-evm.

Patches are based on on 3.14-rc4 with balbi/next, linux-phy/next,
omap-for-v3.15/dt merged and [1] applied.

[1] - http://article.gmane.org/gmane.linux.drivers.devicetree/65223.

cheers,
-roger

---
Roger Quadros (8):
  CLK: ti: dra7: Initialize USB_DPLL
  ARM: dts: dra7-clock: Add "l3init_960m_gfclk" clock gate
  ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
  phy: omap-usb2: Use generic clock names "wkupclk" and "refclk"
  phy: omap-usb2: Add clock names to Documentation binding
  ARM: dts: omap4+: Add clocks to USB2 PHY node
  ARM: dts: dra7: Add USB related nodes
  dts: dra7-evm: add USB support

 Documentation/devicetree/bindings/phy/ti-phy.txt |   7 ++
 arch/arm/boot/dts/dra7-evm.dts                   |  24 +++++
 arch/arm/boot/dts/dra7.dtsi                      | 110 +++++++++++++++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi             |  12 ++-
 arch/arm/boot/dts/omap4.dtsi                     |   2 +
 arch/arm/boot/dts/omap5.dtsi                     |   2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c        |  22 ++---
 drivers/clk/ti/clk-7xx.c                         |  11 +++
 drivers/phy/phy-omap-usb2.c                      |   8 +-
 9 files changed, 182 insertions(+), 16 deletions(-)

-- 
1.8.3.2
