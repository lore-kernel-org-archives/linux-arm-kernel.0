From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 5 Nov 2012 16:15:42 +0530
Subject: [PATCH 02/10] ARM: dts: AM33XX: Add matrix keypad device tree data to
 am335x-evm
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352112350-13398-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add matrix keypad device tree data to am335x-evm by adding all
the necessary parameters like keymap, row & column gpios and etc.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 9199456..8076e66 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -110,6 +110,26 @@
 		regulator-name = "lis3_reg";
 		regulator-boot-on;
 	};
+
+	matrix_keypad: matrix_keypad at 0 {
+		compatible = "gpio-matrix-keypad";
+		debounce-delay-ms = <5>;
+		col-scan-delay-us = <2>;
+
+		row-gpios = <&gpio2 25 0	/* Bank1, pin25 */
+			     &gpio2 26 0	/* Bank1, pin26 */
+			     &gpio2 27 0>;	/* Bank1, pin27 */
+
+		col-gpios = <&gpio2 21 0	/* Bank1, pin21 */
+			     &gpio2 22 0>;	/* Bank1, pin22 */
+
+		linux,keymap = <0x0000008b	/* MENU */
+				0x0100009e	/* BACK */
+				0x02000069	/* LEFT */
+				0x0001006a	/* RIGHT */
+				0x0101001c	/* ENTER */
+				0x0201006c>;	/* DOWN */
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.9.5
