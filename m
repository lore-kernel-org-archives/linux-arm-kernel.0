From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  2 Apr 2012 15:01:24 +0800
Subject: [PATCH] ARM: imx: rename uart and fec device tree nodes
Message-ID: <1333350084-5993-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has been pointed out by device tree maintainer for several times
that the generic names 'serial' and 'ethernet' should be used for
those devices per ePAPR.  Renames imx uart and fec device tree nodes
to stop them being bad examples.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/net/fsl-fec.txt  |    2 +-
 .../bindings/tty/serial/fsl-imx-uart.txt           |    2 +-
 arch/arm/boot/dts/imx27-phytec-phycore.dts         |    8 ++++----
 arch/arm/boot/dts/imx27.dtsi                       |   14 +++++++-------
 arch/arm/boot/dts/imx51-babbage.dts                |    8 ++++----
 arch/arm/boot/dts/imx51.dtsi                       |    8 ++++----
 arch/arm/boot/dts/imx53-ard.dts                    |    2 +-
 arch/arm/boot/dts/imx53-evk.dts                    |    4 ++--
 arch/arm/boot/dts/imx53-qsb.dts                    |    4 ++--
 arch/arm/boot/dts/imx53-smd.dts                    |    8 ++++----
 arch/arm/boot/dts/imx53.dtsi                       |   12 ++++++------
 arch/arm/boot/dts/imx6q-arm2.dts                   |    4 ++--
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    4 ++--
 arch/arm/boot/dts/imx6q.dtsi                       |   12 ++++++------
 arch/arm/mach-imx/clock-imx6q.c                    |   12 ++++++------
 15 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index de43951..7ab9e1a 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -14,7 +14,7 @@ Optional properties:
 
 Example:
 
-fec at 83fec000 {
+ethernet at 83fec000 {
 	compatible = "fsl,imx51-fec", "fsl,imx27-fec";
 	reg = <0x83fec000 0x4000>;
 	interrupts = <87>;
diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
index a9c0406..b462d0c 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
@@ -11,7 +11,7 @@ Optional properties:
 
 Example:
 
-uart at 73fbc000 {
+serial at 73fbc000 {
 	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 	reg = <0x73fbc000 0x4000>;
 	interrupts = <31>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index a51a08f..2b0ff60 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -27,22 +27,22 @@
 				status = "okay";
 			};
 
-			uart at 1000a000 {
+			serial at 1000a000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-			uart at 1000b000 {
+			serial at 1000b000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-			uart at 1000c000 {
+			serial at 1000c000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-			fec at 1002b000 {
+			ethernet at 1002b000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index bc5e7d5..2b1a166 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -59,28 +59,28 @@
 				status = "disabled";
 			};
 
-			uart1: uart at 1000a000 {
+			uart1: serial at 1000a000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
 				interrupts = <20>;
 				status = "disabled";
 			};
 
-			uart2: uart at 1000b000 {
+			uart2: serial at 1000b000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000b000 0x1000>;
 				interrupts = <19>;
 				status = "disabled";
 			};
 
-			uart3: uart at 1000c000 {
+			uart3: serial at 1000c000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000c000 0x1000>;
 				interrupts = <18>;
 				status = "disabled";
 			};
 
-			uart4: uart at 1000d000 {
+			uart4: serial at 1000d000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000d000 0x1000>;
 				interrupts = <17>;
@@ -183,14 +183,14 @@
 				status = "disabled";
 			};
 
-			uart5: uart at 1001b000 {
+			uart5: serial at 1001b000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1001b000 0x1000>;
 				interrupts = <49>;
 				status = "disabled";
 			};
 
-			uart6: uart at 1001c000 {
+			uart6: serial at 1001c000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1001c000 0x1000>;
 				interrupts = <48>;
@@ -206,7 +206,7 @@
 				status = "disabled";
 			};
 
-			fec: fec at 1002b000 {
+			fec: ethernet at 1002b000 {
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
 				interrupts = <50>;
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index fd729d4..d42a404 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -36,7 +36,7 @@
 					status = "okay";
 				};
 
-				uart3: uart at 7000c000 {
+				uart3: serial at 7000c000 {
 					fsl,uart-has-rtscts;
 					status = "okay";
 				};
@@ -173,12 +173,12 @@
 				reg = <0x73fa8000 0x4000>;
 			};
 
-			uart1: uart at 73fbc000 {
+			uart1: serial at 73fbc000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-			uart2: uart at 73fc0000 {
+			uart2: serial at 73fc0000 {
 				status = "okay";
 			};
 		};
@@ -197,7 +197,7 @@
 				};
 			};
 
-			fec at 83fec000 {
+			ethernet at 83fec000 {
 				phy-mode = "mii";
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 6663986..66f0ebd 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -86,7 +86,7 @@
 					status = "disabled";
 				};
 
-				uart3: uart at 7000c000 {
+				uart3: serial at 7000c000 {
 					compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 					reg = <0x7000c000 0x4000>;
 					interrupts = <33>;
@@ -171,14 +171,14 @@
 				status = "disabled";
 			};
 
-			uart1: uart at 73fbc000 {
+			uart1: serial at 73fbc000 {
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fbc000 0x4000>;
 				interrupts = <31>;
 				status = "disabled";
 			};
 
-			uart2: uart at 73fc0000 {
+			uart2: serial at 73fc0000 {
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fc0000 0x4000>;
 				interrupts = <32>;
@@ -235,7 +235,7 @@
 				status = "disabled";
 			};
 
-			fec at 83fec000 {
+			ethernet at 83fec000 {
 				compatible = "fsl,imx51-fec", "fsl,imx27-fec";
 				reg = <0x83fec000 0x4000>;
 				interrupts = <87>;
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 4c61b7f..5b8eafc 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -40,7 +40,7 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart1: uart at 53fbc000 {
+			uart1: serial at 53fbc000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 8ce5fe1..9c79803 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -71,7 +71,7 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart1: uart at 53fbc000 {
+			uart1: serial at 53fbc000 {
 				status = "okay";
 			};
 		};
@@ -95,7 +95,7 @@
 				};
 			};
 
-			fec at 63fec000 {
+			ethernet at 63fec000 {
 				phy-mode = "rmii";
 				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index de34a17..b08b587 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -45,7 +45,7 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart1: uart at 53fbc000 {
+			uart1: serial at 53fbc000 {
 				status = "okay";
 			};
 		};
@@ -78,7 +78,7 @@
 				};
 			};
 
-			fec at 63fec000 {
+			ethernet at 63fec000 {
 				phy-mode = "rmii";
 				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index a984fa5..a3529af 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -35,7 +35,7 @@
 					status = "okay";
 				};
 
-				uart3: uart at 5000c000 {
+				uart3: serial at 5000c000 {
 					fsl,uart-has-rtscts;
 					status = "okay";
 				};
@@ -86,11 +86,11 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart1: uart at 53fbc000 {
+			uart1: serial at 53fbc000 {
 				status = "okay";
 			};
 
-			uart2: uart at 53fc0000 {
+			uart2: serial at 53fc0000 {
 				status = "okay";
 			};
 		};
@@ -138,7 +138,7 @@
 				};
 			};
 
-			fec at 63fec000 {
+			ethernet at 63fec000 {
 				phy-mode = "rmii";
 				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 5dd91b9..5188615 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -88,7 +88,7 @@
 					status = "disabled";
 				};
 
-				uart3: uart at 5000c000 {
+				uart3: serial at 5000c000 {
 					compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 					reg = <0x5000c000 0x4000>;
 					interrupts = <33>;
@@ -173,14 +173,14 @@
 				status = "disabled";
 			};
 
-			uart1: uart at 53fbc000 {
+			uart1: serial at 53fbc000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <31>;
 				status = "disabled";
 			};
 
-			uart2: uart at 53fc0000 {
+			uart2: serial at 53fc0000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fc0000 0x4000>;
 				interrupts = <32>;
@@ -226,7 +226,7 @@
 				status = "disabled";
 			};
 
-			uart4: uart at 53ff0000 {
+			uart4: serial at 53ff0000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <13>;
@@ -241,7 +241,7 @@
 			reg = <0x60000000 0x10000000>;
 			ranges;
 
-			uart5: uart at 63f90000 {
+			uart5: serial at 63f90000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x63f90000 0x4000>;
 				interrupts = <86>;
@@ -290,7 +290,7 @@
 				status = "disabled";
 			};
 
-			fec at 63fec000 {
+			ethernet at 63fec000 {
 				compatible = "fsl,imx53-fec", "fsl,imx25-fec";
 				reg = <0x63fec000 0x4000>;
 				interrupts = <87>;
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 1b2b64f..9c468d2 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -23,7 +23,7 @@
 
 	soc {
 		aips-bus at 02100000 { /* AIPS2 */
-			enet at 02188000 {
+			ethernet at 02188000 {
 				phy-mode = "rgmii";
 				local-mac-address = [00 04 9F 01 1B 61];
 				status = "okay";
@@ -42,7 +42,7 @@
 				status = "okay";
 			};
 
-			uart4: uart at 021f0000 {
+			uart4: serial at 021f0000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 4663a4e..a93c593 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -23,7 +23,7 @@
 
 	soc {
 		aips-bus at 02100000 { /* AIPS2 */
-			enet at 02188000 {
+			ethernet at 02188000 {
 				phy-mode = "rgmii";
 				phy-reset-gpios = <&gpio3 23 0>;
 				status = "okay";
@@ -43,7 +43,7 @@
 				status = "okay";
 			};
 
-			uart2: uart at 021e8000 {
+			uart2: serial at 021e8000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 68f2e42..56c5304 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -165,7 +165,7 @@
 					status = "disabled";
 				};
 
-				uart1: uart at 02020000 {
+				uart1: serial at 02020000 {
 					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 0x04>;
@@ -506,7 +506,7 @@
 				reg = <0x0217c000 0x4000>;
 			};
 
-			enet at 02188000 {
+			ethernet at 02188000 {
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupts = <0 118 0x04 0 119 0x04>;
@@ -627,28 +627,28 @@
 				interrupts = <0 18 0x04>;
 			};
 
-			uart2: uart at 021e8000 {
+			uart2: serial at 021e8000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021e8000 0x4000>;
 				interrupts = <0 27 0x04>;
 				status = "disabled";
 			};
 
-			uart3: uart at 021ec000 {
+			uart3: serial at 021ec000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021ec000 0x4000>;
 				interrupts = <0 28 0x04>;
 				status = "disabled";
 			};
 
-			uart4: uart at 021f0000 {
+			uart4: serial at 021f0000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f0000 0x4000>;
 				interrupts = <0 29 0x04>;
 				status = "disabled";
 			};
 
-			uart5: uart at 021f4000 {
+			uart5: serial at 021f4000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f4000 0x4000>;
 				interrupts = <0 30 0x04>;
diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 111c328..be049d1 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1952,12 +1952,12 @@ static struct clk sata_clk = {
 	}
 
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK("2020000.uart", NULL, uart_clk),
-	_REGISTER_CLOCK("21e8000.uart", NULL, uart_clk),
-	_REGISTER_CLOCK("21ec000.uart", NULL, uart_clk),
-	_REGISTER_CLOCK("21f0000.uart", NULL, uart_clk),
-	_REGISTER_CLOCK("21f4000.uart", NULL, uart_clk),
-	_REGISTER_CLOCK("2188000.enet", NULL, enet_clk),
+	_REGISTER_CLOCK("2020000.serial", NULL, uart_clk),
+	_REGISTER_CLOCK("21e8000.serial", NULL, uart_clk),
+	_REGISTER_CLOCK("21ec000.serial", NULL, uart_clk),
+	_REGISTER_CLOCK("21f0000.serial", NULL, uart_clk),
+	_REGISTER_CLOCK("21f4000.serial", NULL, uart_clk),
+	_REGISTER_CLOCK("2188000.ethernet", NULL, enet_clk),
 	_REGISTER_CLOCK("2190000.usdhc", NULL, usdhc1_clk),
 	_REGISTER_CLOCK("2194000.usdhc", NULL, usdhc2_clk),
 	_REGISTER_CLOCK("2198000.usdhc", NULL, usdhc3_clk),
-- 
1.7.5.4
