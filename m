From: rogerq@ti.com (Roger Quadros)
Date: Wed, 12 Feb 2014 12:18:41 +0200
Subject: [PATCH v7 00/12] USB Host support for OMAP5 uEVM
Message-ID: <1392200333-28397-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit, Tony & Lee,

This patchset brings up USB Host ports and Ethernet port on
the OMAP5 uEVM board. Please queue these for -next.

Tested on:
 - OMAP5 uEVM
 - Pandaboard ES Rev. B1
 - Beagleboard-XM Rev C2
 - Beagleboard Rev C4.

Changelog:

v7:
- Rebased on 3.14-rc2
- Removed incompatible ids from DT files and examples

v6:
- Initialized clocks to -ENODEV and split patch 3.

v5:
- Expose all clocks in the DT binding document for mfd:omap-usb-host
and mfd:omap-usb-tll

v4:
- Updated DT binding document for clock binding

v3:
- Rebased on top of 3.13-rc7

cheers,
-roger

--

Roger Quadros (12):
  mfd: omap-usb-host: Use resource managed clk_get()
  mfd: omap-usb-host: Get clocks based on hardware revision
  mfd: omap-usb-host: Use clock names as per function for reference
    clocks
  mfd: omap-usb-host: Update DT clock binding information
  mfd: omap-usb-tll: Update DT clock binding information
  ARM: dts: omap4: Update omap-usb-host node
  ARM: dts: omap5: Update omap-usb-host node
  ARM: dts: omap4-panda: Provide USB PHY clock
  ARM: dts: omap5-uevm: Provide USB PHY clock
  ARM: OMAP2+: Remove legacy_init_ehci_clk()
  ARM: dts: OMAP2+: Get rid of incompatible ids for USB host nodes
  usb: omap: dts: Update DT binding example usage

 .../devicetree/bindings/mfd/omap-usb-host.txt      |  23 +++
 .../devicetree/bindings/mfd/omap-usb-tll.txt       |  10 ++
 .../devicetree/bindings/usb/ehci-omap.txt          |   2 +-
 .../devicetree/bindings/usb/ohci-omap3.txt         |   2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   4 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
 arch/arm/boot/dts/omap4.dtsi                       |  10 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |   8 +-
 arch/arm/boot/dts/omap5.dtsi                       |  10 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  16 --
 drivers/mfd/omap-usb-host.c                        | 171 ++++++++++-----------
 11 files changed, 136 insertions(+), 128 deletions(-)

-- 
1.8.3.2
