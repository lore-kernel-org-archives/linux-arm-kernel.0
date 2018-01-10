From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Jan 2018 09:21:04 +0100
Subject: [PATCH 4/7] ARM: dts: STi: Move leds node outside soc node
In-Reply-To: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
References: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515572469-19276-5-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Leds are not part of soc, so nove them outside soc node.
This allows to fix the following warnings when compiling
dtb with W=1 option :

arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/leds missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/leds missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/leds missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410-b2260.dts  | 49 ++++++++++++++++++------------------
 arch/arm/boot/dts/stih418-b2199.dts  | 26 +++++++++----------
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 26 +++++++++----------
 3 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index faafc7b..69c2abc 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -29,36 +29,35 @@
 		ethernet0 = &ethernet0;
 	};
 
-	soc {
-
-		leds {
-			compatible = "gpio-leds";
-			user_green_1 {
-				label = "User_green_1";
-				gpios = <&pio1 3 GPIO_ACTIVE_LOW>;
-				linux,default-trigger = "heartbeat";
-				default-state = "off";
-			};
+	leds {
+		compatible = "gpio-leds";
+		user_green_1 {
+			label = "User_green_1";
+			gpios = <&pio1 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
 
-			user_green_2 {
-				label = "User_green_2";
-				gpios = <&pio4 1 GPIO_ACTIVE_LOW>;
-				default-state = "off";
-			};
+		user_green_2 {
+			label = "User_green_2";
+			gpios = <&pio4 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
 
-			user_green_3 {
-				label = "User_green_3";
-				gpios = <&pio2 1 GPIO_ACTIVE_LOW>;
-				default-state = "off";
-			};
+		user_green_3 {
+			label = "User_green_3";
+			gpios = <&pio2 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
 
-			user_green_4 {
-				label = "User_green_4";
-				gpios = <&pio2 5 GPIO_ACTIVE_LOW>;
-				default-state = "off";
-			};
+		user_green_4 {
+			label = "User_green_4";
+			gpios = <&pio2 5 GPIO_ACTIVE_LOW>;
+			default-state = "off";
 		};
+	};
 
+	soc {
 		/* Low speed expansion connector */
 		uart0: serial at 9830000 {
 			label = "LS-UART0";
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 5418a0e..1ce38ce 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -28,24 +28,24 @@
 		ethernet0 = &ethernet0;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		red {
+			label = "Front Panel LED";
+			gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+		green {
+			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
 	soc {
 		sbc_serial0: serial at 9530000 {
 			status = "okay";
 		};
 
-		leds {
-			compatible = "gpio-leds";
-			red {
-				label = "Front Panel LED";
-				gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "heartbeat";
-			};
-			green {
-				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-		};
-
 		i2c at 9842000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 68783e8..1fd3a2b 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -10,24 +10,24 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/media/c8sectpfe.h>
 / {
+	leds {
+		compatible = "gpio-leds";
+		red {
+			label = "Front Panel LED";
+			gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+		green {
+			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
 	soc {
 		sbc_serial0: serial at 9530000 {
 			status = "okay";
 		};
 
-		leds {
-			compatible = "gpio-leds";
-			red {
-				label = "Front Panel LED";
-				gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "heartbeat";
-			};
-			green {
-				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-		};
-
 		pwm0: pwm at 9810000 {
 			status = "okay";
 		};
-- 
1.9.1
