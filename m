From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:23 +0200
Subject: [PATCH 11/38] ARM: dts: r8a7745: Add Inter Connect RAM
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <825216b8160b53b83f405a1e7b6c647e4e99e25a.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

RZ/G1E has 3 regions of Inter Connect RAM (72 + 4 + 256 KiB).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 2feb0084bb3b..88cf92bcd2f9 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -468,6 +468,21 @@
 			status = "disabled";
 		};
 
+		icram2:	sram at e6300000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe6300000 0 0x40000>;
+		};
+
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+		};
+
+		icram1:	sram at e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+		};
+
 		ether: ethernet at ee700000 {
 			compatible = "renesas,ether-r8a7745";
 			reg = <0 0xee700000 0 0x400>;
-- 
2.1.4
