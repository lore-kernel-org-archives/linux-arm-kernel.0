From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:42 -0700
Subject: [PATCH v3 1/9] ARM: dts: consolidate aliases for Cygnus dt files
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442873570-20947-2-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move aliases into bcm-cygnus.dtsi to avoid duplications in Cygnus dts
files

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi      | 4 ++++
 arch/arm/boot/dts/bcm911360_entphn.dts | 4 ----
 arch/arm/boot/dts/bcm911360k.dts       | 4 ----
 arch/arm/boot/dts/bcm958300k.dts       | 4 ----
 arch/arm/boot/dts/bcm958305k.dts       | 4 ----
 5 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index e1ac07a..30903ba 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -40,6 +40,10 @@
 	model = "Broadcom Cygnus SoC";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 7db4843..0e1320e 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -39,10 +39,6 @@
 	model = "Cygnus Enterprise Phone (BCM911360_ENTPHN)";
 	compatible = "brcm,bcm11360", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
diff --git a/arch/arm/boot/dts/bcm911360k.dts b/arch/arm/boot/dts/bcm911360k.dts
index 9658d4f..2af40c6 100644
--- a/arch/arm/boot/dts/bcm911360k.dts
+++ b/arch/arm/boot/dts/bcm911360k.dts
@@ -38,10 +38,6 @@
 	model = "Cygnus SVK (BCM911360K)";
 	compatible = "brcm,bcm11360", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/bcm958300k.dts
index 2f63052..75e50f0 100644
--- a/arch/arm/boot/dts/bcm958300k.dts
+++ b/arch/arm/boot/dts/bcm958300k.dts
@@ -38,10 +38,6 @@
 	model = "Cygnus SVK (BCM958300K)";
 	compatible = "brcm,bcm58300", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
index 56b429a..bf62e1b 100644
--- a/arch/arm/boot/dts/bcm958305k.dts
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -38,10 +38,6 @@
 	model = "Cygnus Wireless Audio (BCM958305K)";
 	compatible = "brcm,bcm58305", "brcm,cygnus";
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
-- 
1.9.1
