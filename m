From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 15:27:32 +0000
Subject: [PATCH 5/5] ARM: dts: armada388-clearfog: move uart nodes
In-Reply-To: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
References: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO4WK-00006O-3M@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the uart nodes over to use the label form to reference the serial
devices, rather than replicating the device node path.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dtsi          | 14 +++++++-------
 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 6149699eefc2..0f5938bede53 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -93,13 +93,6 @@
 				wp-inverted;
 			};
 
-			serial at 12100 {
-				/* mikrobus uart */
-				pinctrl-0 = <&mikro_uart_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-			};
-
 			usb at 58000 {
 				/* CON3, nearest  power. */
 				status = "okay";
@@ -305,3 +298,10 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&uart1 {
+	/* mikrobus uart */
+	pinctrl-0 = <&mikro_uart_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index 681962a6395b..458884ff4c8c 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -69,12 +69,6 @@
 				 */
 				status = "okay";
 			};
-
-			serial at 12000 {
-				pinctrl-0 = <&uart0_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-			};
 		};
 	};
 };
@@ -144,3 +138,9 @@
 		status = "disabled";
 	};
 };
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.7.4
