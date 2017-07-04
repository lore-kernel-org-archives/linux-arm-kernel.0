From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:23:17 +0200
Subject: [PATCH 6/7] ARM: dts: r8a7793: Add Inter Connect RAM
In-Reply-To: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
References: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499181798-28859-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car M2-N has 2 regions of Inter Connect RAM (72 + 4 KiB).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 13b980f27bbc885f..bc6a44272f555215 100644
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
2.7.4
