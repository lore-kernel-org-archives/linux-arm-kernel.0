From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Mar 2013 15:23:33 +0100
Subject: [PATCH 1/4] ARM: at91/dt: fix macb node declaration
In-Reply-To: <cover.1363960549.git.nicolas.ferre@atmel.com>
References: <cover.1363960549.git.nicolas.ferre@atmel.com>
Message-ID: <de2f34900ed05369639eb613ee183949411d9f77.1363960549.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Macb0 node cannot be activated in generic sam9x5ek.dtsi file
as the sam9g15 does not have one.
Move the macb0 & macb1 activation in board .dts file that
support them.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9g35ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9x25ek.dts | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9x35ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi |  5 -----
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index c5ab16f..a1c511f 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -13,4 +13,13 @@
 / {
 	model = "Atmel AT91SAM9G25-EK";
 	compatible = "atmel,at91sam9g25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	ahb {
+		apb {
+			macb0: ethernet at f802c000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g35ek.dts b/arch/arm/boot/dts/at91sam9g35ek.dts
index 95944bd..6f58ab8 100644
--- a/arch/arm/boot/dts/at91sam9g35ek.dts
+++ b/arch/arm/boot/dts/at91sam9g35ek.dts
@@ -13,4 +13,13 @@
 / {
 	model = "Atmel AT91SAM9G35-EK";
 	compatible = "atmel,at91sam9g35ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	ahb {
+		apb {
+			macb0: ethernet at f802c000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x25ek.dts b/arch/arm/boot/dts/at91sam9x25ek.dts
index af907ea..3b40d11 100644
--- a/arch/arm/boot/dts/at91sam9x25ek.dts
+++ b/arch/arm/boot/dts/at91sam9x25ek.dts
@@ -13,4 +13,18 @@
 / {
 	model = "Atmel AT91SAM9G25-EK";
 	compatible = "atmel,at91sam9x25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	ahb {
+		apb {
+			macb0: ethernet at f802c000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			macb1: ethernet at f8030000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x35ek.dts b/arch/arm/boot/dts/at91sam9x35ek.dts
index 5ccb607..6ad19a0 100644
--- a/arch/arm/boot/dts/at91sam9x35ek.dts
+++ b/arch/arm/boot/dts/at91sam9x35ek.dts
@@ -13,4 +13,13 @@
 / {
 	model = "Atmel AT91SAM9X35-EK";
 	compatible = "atmel,at91sam9x35ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	ahb {
+		apb {
+			macb0: ethernet at f802c000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 8a7cf1d..f7841f6 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -52,11 +52,6 @@
 				status = "okay";
 			};
 
-			macb0: ethernet at f802c000 {
-				phy-mode = "rmii";
-				status = "okay";
-			};
-
 			i2c0: i2c at f8010000 {
 				status = "okay";
 			};
-- 
1.8.0
