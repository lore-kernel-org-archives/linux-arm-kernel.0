From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 29 Oct 2018 09:55:23 -0700
Subject: [PATCH] ARM: dts: NSP: Move aliases to bcm-nsp.dtsi
Message-ID: <20181029165524.26162-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All boards replicate the aliases node, move the aliases node to
bcm-nsp.dtsi and add all the serial and ethernet ports such that a boot
program like u-boot can populate MAC addresses accordingly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 8 ++++++++
 arch/arm/boot/dts/bcm958522er.dts  | 4 ----
 arch/arm/boot/dts/bcm958525er.dts  | 4 ----
 arch/arm/boot/dts/bcm958525xmc.dts | 4 ----
 arch/arm/boot/dts/bcm958622hr.dts  | 4 ----
 arch/arm/boot/dts/bcm958623hr.dts  | 4 ----
 arch/arm/boot/dts/bcm958625hr.dts  | 4 ----
 arch/arm/boot/dts/bcm958625k.dts   | 5 -----
 arch/arm/boot/dts/bcm988312hr.dts  | 4 ----
 9 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index ec869a80f9ba..cbe6c6453d76 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -41,6 +41,14 @@
 	model = "Broadcom Northstar Plus SoC";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		ethernet0 = &amac0;
+		ethernet1 = &amac1;
+		ethernet2 = &amac2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index f9dd342cc2ae..21479b4ce823 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958522ER)";
 	compatible = "brcm,bcm58522", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index 374508a9cfbf..cda3d790965b 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958525ER)";
 	compatible = "brcm,bcm58525", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 403250c5ad8e..f86649812b59 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus XMC (BCM958525xmc)";
 	compatible = "brcm,bcm58525", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index ecd05e26c262..df60602b054d 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958622HR)";
 	compatible = "brcm,bcm58622", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index f5e85b301497..3893e7af343a 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958623HR)";
 	compatible = "brcm,bcm58623", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index a53a2f629d74..cf226b02141f 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM958625HR)";
 	compatible = "brcm,bcm58625", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 3ea5f739e90b..10b3d512bb33 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -38,11 +38,6 @@
 	model = "NorthStar Plus SVK (BCM958625K)";
 	compatible = "brcm,bcm58625", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index ea9a0806b446..e39db14d805e 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -39,10 +39,6 @@
 	model = "NorthStar Plus SVK (BCM988312HR)";
 	compatible = "brcm,bcm88312", "brcm,nsp";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.17.1
