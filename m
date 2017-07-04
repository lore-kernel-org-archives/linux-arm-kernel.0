From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:23:18 +0200
Subject: [PATCH 7/7] ARM: dts: r8a7794: Add Inter Connect RAM
In-Reply-To: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
References: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499181798-28859-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car E2 has 2 regions of Inter Connect RAM (72 + 4 KiB).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 7d9a81d970d87c6b..78973cee7185ffe6 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -588,6 +588,16 @@
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
 		compatible = "renesas,ether-r8a7794";
 		reg = <0 0xee700000 0 0x400>;
-- 
2.7.4
