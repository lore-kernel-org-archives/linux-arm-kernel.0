From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 14 Nov 2014 11:08:50 +0100
Subject: [PATCH 2/4] ARM: at91/dt: add GPBR nodes
In-Reply-To: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415959732-13591-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPBR (General Purpose Block Backup Registers) nodes.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9261.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9rl.dtsi  | 6 ++++++
 5 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 9ea824e..dd1313c 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -974,6 +974,12 @@
 				atmel,idle-halt;
 				status = "disabled";
 			};
+
+			gpbr: syscon at fffffd50 {
+				compatible = "atmel,at91sam9260-gpbr", "syscon";
+				reg = <0xfffffd50 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 06b11fc..cdb9ed6 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -842,6 +842,12 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				status = "disabled";
 			};
+
+			gpbr: syscon at fffffd50 {
+				compatible = "atmel,at91sam9260-gpbr", "syscon";
+				reg = <0xfffffd50 0x10>;
+				status = "disabled";
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 7f37b7e..1467750 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -939,6 +939,12 @@
 				clocks = <&slow_xtal>;
 				status = "disabled";
 			};
+
+			gpbr: syscon at fffffd60 {
+				compatible = "atmel,at91sam9260-gpbr", "syscon";
+				reg = <0xfffffd60 0x50>;
+				status = "disabled";
+			};
 		};
 
 		fb0: fb at 0x00700000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 3771088..18453d9 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1206,6 +1206,12 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				status = "disabled";
 			};
+
+			gpbr: syscon at fffffd60 {
+				compatible = "atmel,at91sam9260-gpbr", "syscon";
+				reg = <0xfffffd60 0x10>;
+				status = "disabled";
+			};
 		};
 
 		fb0: fb at 0x00500000 {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 6d77b02..2ff072b 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -1067,6 +1067,12 @@
 				clocks = <&clk32k>;
 				status = "disabled";
 			};
+
+			gpbr: syscon at fffffd60 {
+				compatible = "atmel,at91sam9260-gpbr", "syscon";
+				reg = <0xfffffd60 0x10>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
1.9.1
