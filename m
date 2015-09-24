From: rjui@broadcom.com (Ray Jui)
Date: Thu, 24 Sep 2015 15:21:23 -0700
Subject: [PATCH] ARM: dts: move aliases back to .dts in Cygnus
Message-ID: <1443133283-29025-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move aliases from bcm-cygnus.dtsi back to individual .dts files. Also
clean up the chosen node to have the stdout-path using the proper alias

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ----
 arch/arm/boot/dts/bcm911360k.dts  | 7 +++++--
 arch/arm/boot/dts/bcm958300k.dts  | 7 +++++--
 arch/arm/boot/dts/bcm958305k.dts  | 7 +++++--
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index b5f9f34..2778533 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -41,10 +41,6 @@
 	model = "Broadcom Cygnus SoC";
 	interrupt-parent = <&gic>;
 
-	aliases {
-		serial0 = &uart3;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm911360k.dts b/arch/arm/boot/dts/bcm911360k.dts
index 814011c..091c73a 100644
--- a/arch/arm/boot/dts/bcm911360k.dts
+++ b/arch/arm/boot/dts/bcm911360k.dts
@@ -38,9 +38,12 @@
 	model = "Cygnus SVK (BCM911360K)";
 	compatible = "brcm,bcm11360", "brcm,cygnus";
 
+	aliases {
+		serial0 = &uart3;
+	};
+
 	chosen {
-		stdout-path = &uart3;
-		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
 	};
 };
 
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/bcm958300k.dts
index 2e31581..b4a1392 100644
--- a/arch/arm/boot/dts/bcm958300k.dts
+++ b/arch/arm/boot/dts/bcm958300k.dts
@@ -39,9 +39,12 @@
 	model = "Cygnus SVK (BCM958300K)";
 	compatible = "brcm,bcm58300", "brcm,cygnus";
 
+	aliases {
+		serial0 = &uart3;
+	};
+
 	chosen {
-		stdout-path = &uart3;
-		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
 	};
 };
 
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
index 288a637..3378683 100644
--- a/arch/arm/boot/dts/bcm958305k.dts
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -39,9 +39,12 @@
 	model = "Cygnus Wireless Audio (BCM958305K)";
 	compatible = "brcm,bcm58305", "brcm,cygnus";
 
+	aliases {
+		serial0 = &uart3;
+	};
+
 	chosen {
-		stdout-path = &uart3;
-		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
 	};
 };
 
-- 
1.9.1
