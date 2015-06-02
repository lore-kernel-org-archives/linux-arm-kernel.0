From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Jun 2015 20:29:09 +0800
Subject: [PATCH 0/3] ARM: dts: sun8i: Support USB hosts
Message-ID: <1433248152-13753-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,


Allwinner A23/A33 have 2 USB PHYs, 1 for OTG and 1 for a normal
EHCI/OHCI USB host pair. This series adds support for EHCI/OHCI.
The SoC also supports HSIC, however no boards actually use it, so
this is not implemented yet.

Patch 1 adds a new compatible for sun8i-a23 usb phys. It differs
from previous ones in just the number of phys and how reset controls
are routed.

Patch 2 adds device nodes for USB PHYs and hosts for A23/A33.

Patch 3 enables the USB hosts on the SinA33 dev board. On this
board, VBUS is always on.

It's probably too late for 4.2, but I'd still like to try and
get this merged.


Regards
ChenYu


Chen-Yu Tsai (3):
  phy: sun4i-usb: Add support for sun8i A23/A33
  ARM: dts: sun8i: Add support for USB controllers on A23/A33
  ARM: dts: sun8i: sina33: Enable USB hosts

 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  2 ++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 34 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     | 13 +++++++++
 drivers/phy/phy-sun4i-usb.c                        |  7 +++--
 4 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.1.4
