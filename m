From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 15 Mar 2017 18:03:27 +0100
Subject: [PATCH V2 1/2] ARM: dts: BCM5301X: Specify serial console params in
 dtsi files
In-Reply-To: <20170314075830.2247-1-zajec5@gmail.com>
References: <20170314075830.2247-1-zajec5@gmail.com>
Message-ID: <20170315170328.13879-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

So far every Northstar device we have seen was using the same serial
console params (115200n8). It probably make the most sense to put it in
some proper dtsi files instead of repeating over and over for every
single device. As different boards may use different bootloaders it
seems the safest idea is to use board specific dtsi files.

Just in case some vendor decides to use different UART (parameters) this
can be always easily overwritten.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
V2: Use board dtsi files, update existing bcm9*dts files, update commit message.
---
 arch/arm/boot/dts/bcm4708.dtsi    | 8 ++++++++
 arch/arm/boot/dts/bcm47081.dtsi   | 8 ++++++++
 arch/arm/boot/dts/bcm5301x.dtsi   | 4 ----
 arch/arm/boot/dts/bcm94708.dts    | 8 --------
 arch/arm/boot/dts/bcm94709.dts    | 8 --------
 arch/arm/boot/dts/bcm953012er.dts | 8 --------
 arch/arm/boot/dts/bcm953012hr.dts | 8 --------
 arch/arm/boot/dts/bcm953012k.dts  | 4 ----
 8 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
index d0eec099f1f8..1a19e97a987d 100644
--- a/arch/arm/boot/dts/bcm4708.dtsi
+++ b/arch/arm/boot/dts/bcm4708.dtsi
@@ -12,6 +12,14 @@
 / {
 	compatible = "brcm,bcm4708";
 
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm47081.dtsi b/arch/arm/boot/dts/bcm47081.dtsi
index 7bcd536198fc..9829d044aaf4 100644
--- a/arch/arm/boot/dts/bcm47081.dtsi
+++ b/arch/arm/boot/dts/bcm47081.dtsi
@@ -22,6 +22,14 @@
 / {
 	compatible = "brcm,bcm47081";
 
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 8fd1ef9f0c2d..65dc67e86ae1 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -18,10 +18,6 @@
 / {
 	interrupt-parent = <&gic>;
 
-	chosen {
-		stdout-path = &uart0;
-	};
-
 	chipcommonA {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x18000000 0x00001000>;
diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/bcm94708.dts
index 42855a7c1bfa..2e08c895f281 100644
--- a/arch/arm/boot/dts/bcm94708.dts
+++ b/arch/arm/boot/dts/bcm94708.dts
@@ -38,14 +38,6 @@
 	model = "NorthStar SVK (BCM94708)";
 	compatible = "brcm,bcm94708", "brcm,bcm4708";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory {
 		reg = <0x00000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm94709.dts b/arch/arm/boot/dts/bcm94709.dts
index 95e8be65f2f1..c37616c67edc 100644
--- a/arch/arm/boot/dts/bcm94709.dts
+++ b/arch/arm/boot/dts/bcm94709.dts
@@ -38,14 +38,6 @@
 	model = "NorthStar SVK (BCM94709)";
 	compatible = "brcm,bcm94709", "brcm,bcm4709", "brcm,bcm4708";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory {
 		reg = <0x00000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/bcm953012er.dts
index decd86bae901..40e694bfe5ca 100644
--- a/arch/arm/boot/dts/bcm953012er.dts
+++ b/arch/arm/boot/dts/bcm953012er.dts
@@ -39,14 +39,6 @@
 	model = "NorthStar Enterprise Router (BCM953012ER)";
 	compatible = "brcm,bcm953012er", "brcm,brcm53012", "brcm,bcm4708";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory {
 		reg = <0x00000000 0x8000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
index 85f9b0b872ac..5be4225324a3 100644
--- a/arch/arm/boot/dts/bcm953012hr.dts
+++ b/arch/arm/boot/dts/bcm953012hr.dts
@@ -39,14 +39,6 @@
 	model = "NorthStar HR (BCM953012HR)";
 	compatible = "brcm,bcm953012hr", "brcm,brcm53012", "brcm,bcm4708";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory at 80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index a00c4e1dfb4c..fbc6219e977a 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -43,10 +43,6 @@
 		serial1 = &uart1;
 	};
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory {
 		reg = <0x00000000 0x10000000>;
 	};
-- 
2.11.0
