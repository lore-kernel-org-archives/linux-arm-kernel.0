From: yassinjaffer@gmail.com (yassinjaffer at gmail.com)
Date: Wed, 16 Sep 2015 00:05:55 +1000
Subject: [PATCH 2/4] ARM: dts: sun7i: Add keypad node to Allwinner A20 SoC
In-Reply-To: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
Message-ID: <1442325957-10102-3-git-send-email-yassinjaffer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yassin Jaffer <yassinjaffer@gmail.com>

Add Keypad controller node definition to the A20 SoC.

Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 333604a..35cc8d0 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1198,6 +1198,15 @@
 			status = "disabled";
 		};
 
+		kp: kp at 01c23000 {
+			compatible = "allwinner,sun4i-a10-keypad";
+			reg = <0x01c23000 0x400>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 10>, <&keypad_clk>;
+			clock-names = "apb", "keypad";
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
-- 
1.9.1
