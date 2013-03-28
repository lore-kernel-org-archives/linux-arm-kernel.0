From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Thu, 28 Mar 2013 12:12:43 +0530
Subject: [PATCH-V2 6/6] ARM: dts: AM33XX: Add default pinctrl binding for
 UART0 device
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1364452963-22083-7-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin control binding for UART0 device nodes in all
board specific DT files.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Matt Porter <mporter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |   10 ++++++++++
 arch/arm/boot/dts/am335x-evm.dts   |   10 ++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   10 ++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index be2c501..bfba6fc 100644
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
 		uart0: serial at 44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 2f3f5be..f598ed2 100644
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
 		uart0: serial at 44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index bcd7028..0eec644 100644
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
 		uart0: serial at 44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+
 			status = "okay";
 		};

--
1.7.0.4
