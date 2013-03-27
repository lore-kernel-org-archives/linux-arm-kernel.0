From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 27 Mar 2013 18:29:16 +0530
Subject: [PATCH 5/5] ARM: dts: AM33XX: Add default pinctrl binding for UART0
 device
In-Reply-To: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1364389156-8273-6-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin control binding for UART0 device nodes in all
board specific DT files.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |   10 ++++++++++
 arch/arm/boot/dts/am335x-evm.dts   |   10 ++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   10 ++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 1d623e4..3c4c66f 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -43,10 +43,20 @@
 				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
 			>;
 		};
+
+		uart0_pins: pinmux_uart0_pins {
+			pinctrl-single,pins = <
+				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
+				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+			>;
+		};
 	};
 
 	ocp {
 		uart1: serial at 44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 79b3cc8..89e1edd 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -58,10 +58,20 @@
 				0x15c 0x32	/* spi0_cs0.i2c1_scl PULLUP | INPUTENABLE | MODE2 */
 			>;
 		};
+
+		uart0_pins: pinmux_uart0_pins {
+			pinctrl-single,pins = <
+				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
+				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+			>;
+		};
 	};
 
 	ocp {
 		uart1: serial at 44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 21d5a08..0e7f1b8 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -58,10 +58,20 @@
 				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
 			>;
 		};
+
+		uart0_pins: pinmux_uart0_pins {
+			pinctrl-single,pins = <
+				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP | INPUTENABLE | MODE0 */
+				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
+			>;
+		};
 	};
 
 	ocp {
 		uart1: serial at 44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};
 
-- 
1.7.0.4
