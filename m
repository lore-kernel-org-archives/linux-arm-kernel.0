From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Mon, 25 Sep 2017 16:53:49 +0200
Subject: [PATCH 0/3] Enable NAND on Armada-7040-DB board
Message-ID: <20170925145352.13145-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for NAND on Armada-7040-DB board.

Besides standard NAND node addition, it also introduces a new compatible
string for the pxa3xx_nand driver to support the subitilities of A7k/A8k
SoCs, as well as a new property used by the pxa3xx_nand driver to grab a
phandle on the system control node in order to enable the NAND
controller itself.

Regards,
Miquel


Gregory CLEMENT (1):
  arm64: dts: marvell: add NAND support on the 7040-DB board

Miquel Raynal (2):
  Documentation: devicetree: add pxa3xx compatible and syscon property
  mtd: nand: pxa3xx: enable NAND controller if the SoC needs it

 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |  4 +++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 24 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       | 14 ++++++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  3 +-
 drivers/mtd/nand/pxa3xx_nand.c                     | 41 +++++++++++++++++++---
 5 files changed, 81 insertions(+), 5 deletions(-)

-- 
2.11.0
