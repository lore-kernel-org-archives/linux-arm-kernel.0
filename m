From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 12:15:00 +0200
Subject: [PATCH v3 0/8] ARM: OMAP: SATA support for OMAP5 & DRA7
Message-ID: <1394187308-19622-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony & Felipe,

Kishon has pulled in the relevant PHY patches into his tree.
These are the remaining patches from the series.

Patches 1 to 3 need to go through Felipe's USB tree.
Patches 4 to 8 need to go through Tony's OMAP tree.

Thanks.

Patches are based on 3.14-rc4 with balbi/next, linux-phy/next and
omap-for-v3.15/dt merged on top.

To test SATA you will also need [1].

[1] - http://article.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7285

Changelog:
v3
- Removed PHY patches and rebased.

v2
- use 'depends on' instead of 'select' OCP2SCP bus driver.
- Changed DT bindings for dra7-usb2 and am437-usb2 phy.

cheers,
-roger

---
Balaji T K (2):
  ARM: dts: omap5: add sata node
  ARM: dts: dra7: add OCP2SCP3 and SATA nodes

Keshava Munegowda (1):
  ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods

Nikhil Devshatwar (1):
  ARM: DRA7: hwmod: Add ocp2scp3 and sata hwmods

Roger Quadros (4):
  phy: omap-control: update dra7 and am437 usb2 Documentation bindings
  phy: ti-pipe3: Add clocks to PIPE3 PHY Documentation binding
  phy: ti-pipe3: Add SATA compatible to Documentation binding
  ARM: dts: omap5: Add clocks to USB3 PHY node

 Documentation/devicetree/bindings/phy/ti-phy.txt | 19 +++++-
 arch/arm/boot/dts/dra7.dtsi                      | 39 +++++++++++++
 arch/arm/boot/dts/omap5.dtsi                     | 46 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c       | 73 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c        | 31 ++++++++--
 5 files changed, 200 insertions(+), 8 deletions(-)

-- 
1.8.3.2
