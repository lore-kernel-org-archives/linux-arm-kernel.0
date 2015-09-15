From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 15 Sep 2015 19:03:01 +0530
Subject: [PATCH v2 0/4] ARM: dts: use syscon property instead of ctrl-module
Message-ID: <1442323985-29939-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is basically to deprecate using ctrl-module property and use
corresponding syscon properties to program the control module registers.

Changes from v1:
*) Squashed the patches that replaces "ctrl-module" with
   "syscon-phy-power"
*) Added "syscon-phy-power" for SATA dt node in OMAP5 which was missed
   earlier
*) removed _ARM: dts: omap4: Use "syscon-otghs" instead of "ctrl-module"
   in USB node_. It will be done later.

Changes from [1] in PHY patches include
*) cleanup ti_pipe3_probe
*) have mask, power_on and power_off values in usb_phy_data for
   omap-usb2 phy

This series should be merged only after [2]

Did basic enumeration testing to make sure the patch series doesn't
cause any regressions.

[1] -> https://lkml.org/lkml/2015/6/23/189
[2] -> https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg973939.html

Kishon Vijay Abraham I (4):
  ARM: dts: dra7: Add dt node for the sycon pcie
  ARM: dts: dra7: Use "syscon-phy-power" and "syscon-pcs" in PCIe PHY
    node
  ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible string for USB2
    PHY2
  ARM: dts: <am4372/dra7/omap5>: Use "syscon-phy-power" instead of
    "ctrl-module"

 arch/arm/boot/dts/am4372.dtsi |   16 ++--------
 arch/arm/boot/dts/dra7.dtsi   |   69 ++++++++++-------------------------------
 arch/arm/boot/dts/omap5.dtsi  |   26 ++--------------
 3 files changed, 22 insertions(+), 89 deletions(-)

-- 
1.7.9.5
