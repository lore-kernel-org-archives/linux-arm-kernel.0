From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  3 Nov 2018 20:32:35 +0800
Subject: [PATCH v2 0/3] Allwinner H6 Ethernet support
Message-ID: <20181103123238.4665-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces Allwinner H6 Ethernet support with code already
available for A64.

As the EMAC on H6 is similar to A64 ones, support for them are directly
reused, by using fallback compatible strings.

Patches about system controller in v1 is sent by Jernej Skabrec as part
of his H6 display patchset, and already gets applied.

NOTE: This patchset targets the final version of Pine H64, and also
supports the early sample of Pine H64 model B. However, it's not
compatible with the early sample of Pine H64 model A. Please DO NOT test
this patchset on the Pine H64 model A samples.

Icenowy Zheng (3):
  dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
  arm64: allwinner: h6: add EMAC device nodes
  arm64: allwinner: h6: add support for the Ethernet on Pine H64

 .../devicetree/bindings/net/dwmac-sun8i.txt   |  1 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 20 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 28 +++++++++++++++++++
 3 files changed, 49 insertions(+)

-- 
2.18.1
