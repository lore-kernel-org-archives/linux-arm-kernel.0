From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:23:16 +0200
Subject: [PATCH 5/7] ARM: dts: r8a7792: Add Inter Connect RAM
In-Reply-To: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
References: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499181798-28859-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car V2H has 2 regions of Inter Connect RAM (72 + 4 KiB).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7792.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 0efecb232ee52ce0..136a86ac64974adb 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -465,6 +465,16 @@
 			status = "disabled";
 		};
 
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
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a7792";
 			reg = <0 0xee100000 0 0x328>;
-- 
2.7.4
