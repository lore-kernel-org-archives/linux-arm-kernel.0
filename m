From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 24 Apr 2013 17:38:22 +1200
Subject: [PATCH 3/3] dts: vt8500: Update serial nodes and disable by default
 in SoC files
In-Reply-To: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
References: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1366781902-13025-4-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing aliases for uarts on vt8500, wm8505, wm8650 added.
Nodes incorrectly labelled uart at .., changed to serial at ... on all SoCs.
Set each uarts default status = "disabled" as they generally don't exist.

For each board file, we only need to enable uart0 as no other uarts are
physically present on any of these boards.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/vt8500-bv07.dts    |    4 ++++
 arch/arm/boot/dts/vt8500.dtsi        |   19 +++++++++++++++----
 arch/arm/boot/dts/wm8505-ref.dts     |    4 ++++
 arch/arm/boot/dts/wm8505.dtsi        |   27 +++++++++++++++++++++------
 arch/arm/boot/dts/wm8650-mid.dts     |    4 ++++
 arch/arm/boot/dts/wm8650.dtsi        |   11 +++++++++--
 arch/arm/boot/dts/wm8750-apc8750.dts |    4 ++++
 arch/arm/boot/dts/wm8750.dtsi        |   18 ++++++++++++------
 arch/arm/boot/dts/wm8850-w70v2.dts   |    4 ++++
 arch/arm/boot/dts/wm8850.dtsi        |   12 ++++++++----
 10 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/vt8500-bv07.dts b/arch/arm/boot/dts/vt8500-bv07.dts
index 567cf4e..faabc9c 100644
--- a/arch/arm/boot/dts/vt8500-bv07.dts
+++ b/arch/arm/boot/dts/vt8500-bv07.dts
@@ -34,3 +34,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
index e35590e..4908222 100644
--- a/arch/arm/boot/dts/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -21,6 +21,13 @@
 		};
 	};
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -121,32 +128,36 @@
 			reg = <0xd8050400 0x100>;
 		};
 
-		uart at d8200000 {
+		uart0: serial at d8200000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
 			clocks = <&clkuart0>;
+			status = "disabled";
 		};
 
-		uart at d82b0000 {
+		uart1: serial at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
 			clocks = <&clkuart1>;
+			status = "disabled";
 		};
 
-		uart at d8210000 {
+		uart2: serial at d8210000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8210000 0x1040>;
 			interrupts = <47>;
 			clocks = <&clkuart2>;
+			status = "disabled";
 		};
 
-		uart at d82c0000 {
+		uart3: serial at d82c0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82c0000 0x1040>;
 			interrupts = <50>;
 			clocks = <&clkuart3>;
+			status = "disabled";
 		};
 
 		rtc at d8100000 {
diff --git a/arch/arm/boot/dts/wm8505-ref.dts b/arch/arm/boot/dts/wm8505-ref.dts
index fd4e248..acb996f 100644
--- a/arch/arm/boot/dts/wm8505-ref.dts
+++ b/arch/arm/boot/dts/wm8505-ref.dts
@@ -34,3 +34,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index dc21d13..e5076d5 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -21,6 +21,15 @@
 		};
 	};
 
+ 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+ 	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -144,46 +153,52 @@
 			reg = <0xd8050400 0x100>;
 		};
 
-		uart at d8200000 {
+		uart0: serial at d8200000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
 			clocks = <&clkuart0>;
+			status = "disabled";
 		};
 
-		uart at d82b0000 {
+		uart1: serial at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
 			clocks = <&clkuart1>;
+			status = "disabled";
 		};
 
-		uart at d8210000 {
+		uart2: serial at d8210000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8210000 0x1040>;
 			interrupts = <47>;
 			clocks = <&clkuart2>;
+			status = "disabled";
 		};
 
-		uart at d82c0000 {
+		uart3: serial at d82c0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82c0000 0x1040>;
 			interrupts = <50>;
 			clocks = <&clkuart3>;
+			status = "disabled";
 		};
 
-		uart at d8370000 {
+		uart4: serial at d8370000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8370000 0x1040>;
 			interrupts = <31>;
 			clocks = <&clkuart4>;
+			status = "disabled";
 		};
 
-		uart at d8380000 {
+		uart5: serial at d8380000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8380000 0x1040>;
 			interrupts = <30>;
 			clocks = <&clkuart5>;
+			status = "disabled";
 		};
 
 		rtc at d8100000 {
diff --git a/arch/arm/boot/dts/wm8650-mid.dts b/arch/arm/boot/dts/wm8650-mid.dts
index cefd938..fec12f1 100644
--- a/arch/arm/boot/dts/wm8650-mid.dts
+++ b/arch/arm/boot/dts/wm8650-mid.dts
@@ -34,3 +34,7 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index f4cd55e..8e099a8 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -21,6 +21,11 @@
 		};
 	};
 
+ 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -150,18 +155,20 @@
 			reg = <0xd8050400 0x100>;
 		};
 
-		uart at d8200000 {
+		uart0: serial at d8200000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
 			clocks = <&clkuart0>;
+			status = "disabled";
 		};
 
-		uart at d82b0000 {
+		uart1: serial at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
 			clocks = <&clkuart1>;
+			status = "disabled";
 		};
 
 		rtc at d8100000 {
diff --git a/arch/arm/boot/dts/wm8750-apc8750.dts b/arch/arm/boot/dts/wm8750-apc8750.dts
index 62675eb..37e4a40 100644
--- a/arch/arm/boot/dts/wm8750-apc8750.dts
+++ b/arch/arm/boot/dts/wm8750-apc8750.dts
@@ -24,3 +24,7 @@
 		wm,pull = <2>;	/* pull-up */
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/wm8750.dtsi b/arch/arm/boot/dts/wm8750.dtsi
index 81683fa..c048c04 100644
--- a/arch/arm/boot/dts/wm8750.dtsi
+++ b/arch/arm/boot/dts/wm8750.dtsi
@@ -273,46 +273,52 @@
 			interrupts = <26>;
 		};
 
-		uart0: uart at d8200000 {
+		uart0: serial at d8200000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
 			clocks = <&clkuart0>;
+			status = "disabled";
 		};
 
-		uart1: uart at d82b0000 {
+		uart1: serial at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
 			clocks = <&clkuart1>;
+			status = "disabled";
 		};
 
-                uart2: uart at d8210000 {
+                uart2: serial at d8210000 {
                         compatible = "via,vt8500-uart";
                         reg = <0xd8210000 0x1040>;
                         interrupts = <47>;
                         clocks = <&clkuart2>;
+			status = "disabled";
                 };
 
-                uart3: uart at d82c0000 {
+                uart3: serial at d82c0000 {
                         compatible = "via,vt8500-uart";
                         reg = <0xd82c0000 0x1040>;
                         interrupts = <50>;
                         clocks = <&clkuart3>;
+			status = "disabled";
                 };
 
-                uart4: uart at d8370000 {
+                uart4: serial at d8370000 {
                         compatible = "via,vt8500-uart";
                         reg = <0xd8370000 0x1040>;
                         interrupts = <30>;
                         clocks = <&clkuart4>;
+			status = "disabled";
                 };
 
-                uart5: uart at d8380000 {
+                uart5: serial at d8380000 {
                         compatible = "via,vt8500-uart";
                         reg = <0xd8380000 0x1040>;
                         interrupts = <43>;
                         clocks = <&clkuart5>;
+			status = "disabled";
                 };
 
 		rtc at d8100000 {
diff --git a/arch/arm/boot/dts/wm8850-w70v2.dts b/arch/arm/boot/dts/wm8850-w70v2.dts
index fcc660c..5b96ba2 100644
--- a/arch/arm/boot/dts/wm8850-w70v2.dts
+++ b/arch/arm/boot/dts/wm8850-w70v2.dts
@@ -45,3 +45,7 @@
 		default-brightness-level = <5>;
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index 4b56aa0..b5d36e1 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -189,32 +189,36 @@
 			interrupts = <26>;
 		};
 
-		uart0: uart at d8200000 {
+		uart0: serial at d8200000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
 			clocks = <&clkuart0>;
+			status = "disabled";
 		};
 
-		uart1: uart at d82b0000 {
+		uart1: serial at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
 			clocks = <&clkuart1>;
+			status = "disabled";
 		};
 
-                uart2: uart at d8210000 {
+                uart2: serial at d8210000 {
                         compatible = "via,vt8500-uart";
                         reg = <0xd8210000 0x1040>;
                         interrupts = <47>;
                         clocks = <&clkuart2>;
+			status = "disabled";
                 };
 
-                uart3: uart at d82c0000 {
+                uart3: serial at d82c0000 {
                         compatible = "via,vt8500-uart";
                         reg = <0xd82c0000 0x1040>;
                         interrupts = <50>;
                         clocks = <&clkuart3>;
+			status = "disabled";
                 };
 
 		rtc at d8100000 {
-- 
1.7.9.5
