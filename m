From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 30 Dec 2017 19:30:37 +0800
Subject: [PATCH v4 0/6] Allwinner H3/H5/A64(DE2) SimpleFB support (Part 2)
Message-ID: <20171230113043.30237-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is the remaining part of Allwinner DE2 SimpleFB support in
Linux. Some H3/5-related patches are already applied into the sunxi
tree.

PATCH 1 adds the final SimpleFB nodes to the H3/H5 device tree. With it
applied the SimpleFB will be usable on H3/H5.

PATCH 2/3 are for the SRAM requirment of the A64 SoC; PATCH 2 is the
device tree binding of it and PATCH 3 is the implementation in DE2 CCU
of it.

PATCH 4/5 are A64 DTSI file parts; PATCH 4 adds DE2 CCU device node and
PATCH 5 adds SimpleFB device node.

PATCH 6 are A64 per-board DTS file changes, which keeps the regulator
for HVCC pin (a power supply pin on A64 SoC that is used by the HDMI
controller) on these boards.

Icenowy Zheng (6):
  ARM: sunxi: h3/h5: add simplefb nodes
  dt-bindings: add binding for A64 DE2 CCU SRAM
  clk: sunxi-ng: add support for Allwinner A64 DE2 CCU
  arm64: allwinner: a64: add DE2 CCU for A64 SoC
  arm64: allwinner: a64: add simplefb for A64 SoC
  arm64: allwinner: a64: add HDMI regulator to all DTs' simplefb_hdmi

 .../devicetree/bindings/clock/sun8i-de2.txt        |   5 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  24 +++++
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |   4 +
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |   4 +
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |   4 +
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |   4 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   4 +
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |   4 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  60 +++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               | 117 ++++++++++++++-------
 10 files changed, 190 insertions(+), 40 deletions(-)

-- 
2.14.2
