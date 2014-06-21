From: bay@hackerdom.ru (Alexander Bersenev)
Date: Sat, 21 Jun 2014 17:04:05 +0600
Subject: [PATCH v10 4/5] ARM: sunxi: Add IR controllers on A20 to dtsi
In-Reply-To: <1403348646-31091-1-git-send-email-bay@hackerdom.ru>
References: <1403348646-31091-1-git-send-email-bay@hackerdom.ru>
Message-ID: <1403348646-31091-5-git-send-email-bay@hackerdom.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds records for two IR controllers on A20

Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 656d7d3..1782375 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -785,6 +785,24 @@
 			status = "disabled";
 		};
 
+		ir0: ir at 01c21800 {
+			compatible = "allwinner,sun7i-a20-ir";
+			clocks = <&apb0_gates 6>, <&ir0_clk>;
+			clock-names = "apb", "ir";
+			interrupts = <0 5 4>;
+			reg = <0x01c21800 0x40>;
+			status = "disabled";
+		};
+
+		ir1: ir at 01c21c00 {
+			compatible = "allwinner,sun7i-a20-ir";
+			clocks = <&apb0_gates 7>, <&ir1_clk>;
+			clock-names = "apb", "ir";
+			interrupts = <0 6 4>;
+			reg = <0x01c21c00 0x40>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
-- 
1.7.1
