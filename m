From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 22 Dec 2017 20:22:32 +0800
Subject: [PATCH v3 00/11] Allwinner H3/H5/A64(DE2) SimpleFB support
Message-ID: <20171222122243.25735-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the SimpleFB on Allwinner SoCs with
"Display Engine 2.0".

PATCH 1 to PATCH 3 are DE2 CCU fixes for H3/H5 SoCs.

PATCH 4 adds the pipeline strings for DE2 SimpleFB.

PATCH 5 to 7 adds necessary device tree nodes (DE2 CCU and SimpleFB)
for H3/H5 SoCs.

PATCH 8 to 11 are for Allwinner A64 SoC to enable SimpleFB.

Icenowy Zheng (11):
  dt-bindings: fix the binding of Allwinner DE2 CCU of A83T and H3
  clk: sunxi-ng: add support for Allwinner H3 DE2 CCU
  clk: sunxi-ng: fix the A64/H5 clock description of DE2 CCU
  dt-bindings: simplefb-sunxi: add pipelines for DE2
  ARM: sun8i: h3/h5: add DE2 CCU device node for H3
  arm64: allwinner: h5: add compatible string for DE2 CCU
  ARM: sunxi: h3/h5: add simplefb nodes
  dt-bindings: add binding for A64 DE2 CCU SRAM
  clk: sunxi-ng: add support for Allwinner A64 DE2 CCU
  arm64: allwinner: a64: add DE2 CCU for A64 SoC
  arm64: allwinner: a64: add simplefb for A64 SoC

 .../devicetree/bindings/clock/sun8i-de2.txt        | 10 ++-
 .../bindings/display/simple-framebuffer-sunxi.txt  |  4 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  4 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 43 +++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 65 +++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |  4 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               | 85 +++++++++++++++++++---
 7 files changed, 202 insertions(+), 13 deletions(-)

-- 
2.14.2
