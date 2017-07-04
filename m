From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:23:12 +0200
Subject: [PATCH 1/7] ARM: dts: r8a7743: Add Inter Connect RAM
In-Reply-To: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
References: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499181798-28859-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RZ/G1M has 3 regions of Inter Connect RAM (72 + 4 + 256 KiB).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0ddac81742e4cdc7..b8ce935f6fb196fe 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
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
 			compatible = "renesas,ether-r8a7743";
 			reg = <0 0xee700000 0 0x400>;
-- 
2.7.4
