From: rjui@broadcom.com (Ray Jui)
Date: Fri, 18 Sep 2015 14:24:07 -0700
Subject: [PATCH v2 2/9] ARM: dts: Use label for device nodes in Cygnus dts
In-Reply-To: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442611454-16331-3-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use label instead of full path to reference device nodes in Cygnus dts
files

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm911360_entphn.dts |  8 +++----
 arch/arm/boot/dts/bcm911360k.dts       |  6 ++---
 arch/arm/boot/dts/bcm958300k.dts       | 40 +++++++++++++++++-----------------
 arch/arm/boot/dts/bcm958305k.dts       |  6 ++---
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 0e1320e..f791a3b 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -44,10 +44,6 @@
 		bootargs = "console=ttyS0,115200";
 	};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -60,3 +56,7 @@
 		};
 	};
 };
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm911360k.dts b/arch/arm/boot/dts/bcm911360k.dts
index 2af40c6..814011c 100644
--- a/arch/arm/boot/dts/bcm911360k.dts
+++ b/arch/arm/boot/dts/bcm911360k.dts
@@ -42,8 +42,8 @@
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
 	};
+};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
+&uart3 {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/bcm958300k.dts
index 75e50f0..d8dc9f0 100644
--- a/arch/arm/boot/dts/bcm958300k.dts
+++ b/arch/arm/boot/dts/bcm958300k.dts
@@ -42,32 +42,32 @@
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
 	};
+};
 
-	pcie0: pcie at 18012000 {
-		status = "okay";
-	};
+&pcie0 {
+	status = "okay";
+};
 
-	pcie1: pcie at 18013000 {
-		status = "okay";
-	};
+&pcie1 {
+	status = "okay";
+};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
+&uart3 {
+	status = "okay";
+};
 
-	nand: nand at 18046000 {
-		nandcs at 1 {
-			compatible = "brcm,nandcs";
-			reg = <0>;
-			nand-on-flash-bbt;
+&nand {
+	nandcs at 1 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
 
-			#address-cells = <1>;
-			#size-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-			nand-ecc-strength = <24>;
-			nand-ecc-step-size = <1024>;
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <1024>;
 
-			brcm,nand-oob-sector-size = <27>;
-		};
+		brcm,nand-oob-sector-size = <27>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
index bf62e1b..af11a8e 100644
--- a/arch/arm/boot/dts/bcm958305k.dts
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -42,8 +42,8 @@
 		stdout-path = &uart3;
 		bootargs = "console=ttyS0,115200";
 	};
+};
 
-	uart3: serial at 18023000 {
-		status = "okay";
-	};
+&uart3 {
+	status = "okay";
 };
-- 
1.9.1
