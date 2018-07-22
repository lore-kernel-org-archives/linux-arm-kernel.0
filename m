From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 22 Jul 2018 13:39:50 +0800
Subject: [PATCH 0/5] Allwinner H6 Ethernet support
Message-ID: <20180722053955.25266-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces Allwinner H6 Ethernet support with code already
available for A64.

As the system controller and EMAC on H6 are all similar to A64 ones,
support for them are directly reused, by using fallback compatible
strings.

Icenowy Zheng (5):
  dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
  dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
  arm64: allwinner: h6: add system controller device tree node
  arm64: allwinner: h6: add EMAC device nodes
  arm64: allwinner: h6: add support for the Ethernet on Pine H64

 .../devicetree/bindings/net/dwmac-sun8i.txt   |  1 +
 .../devicetree/bindings/sram/sunxi-sram.txt   |  4 ++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 29 ++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 53 +++++++++++++++++++
 4 files changed, 87 insertions(+)

-- 
2.18.0
