From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:27 +0200
Subject: [PATCH 15/38] ARM: dts: r8a7793: Add Inter Connect RAM
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <89d534d96a41c123bf67e419f0d7f7fc02dbcd25.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car M2-N has 2 regions of Inter Connect RAM (72 + 4 KiB).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 13b980f27bbc..bc6a44272f55 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -848,6 +848,16 @@
 		status = "disabled";
 	};
 
+	icram0:	sram at e63a0000 {
+		compatible = "mmio-sram";
+		reg = <0 0xe63a0000 0 0x12000>;
+	};
+
+	icram1:	sram at e63c0000 {
+		compatible = "mmio-sram";
+		reg = <0 0xe63c0000 0 0x1000>;
+	};
+
 	ether: ethernet at ee700000 {
 		compatible = "renesas,ether-r8a7793";
 		reg = <0 0xee700000 0 0x400>;
-- 
2.1.4
