From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 13 Dec 2016 13:13:45 -0500
Subject: [PATCH 1/7] ARM: dts: NSP: DT Clean-ups
In-Reply-To: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
References: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1481652831-2744-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The QSPI entry was added out of the sequental order that the rest of the
DTSI file is in.  Move it to make it fit in properly.  Also, some other
entries have been added in a non-alphabetical order in the DTS files,
making them different from the other NSP DTS files.  Move the relevant
peices to make it match.  Finally, remove errant new lines.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 46 +++++++++++++--------------
 arch/arm/boot/dts/bcm958522er.dts  |  1 -
 arch/arm/boot/dts/bcm958525er.dts  |  1 -
 arch/arm/boot/dts/bcm958525xmc.dts | 26 ++++++++--------
 arch/arm/boot/dts/bcm958623hr.dts  | 16 +++++-----
 arch/arm/boot/dts/bcm958625hr.dts  | 30 +++++++++---------
 arch/arm/boot/dts/bcm958625k.dts   | 64 +++++++++++++++++++-------------------
 7 files changed, 91 insertions(+), 93 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index b6142bd..9cd77ab 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -241,29 +241,6 @@
 			brcm,nand-has-wp;
 		};
 
-		gpiob: gpio at 30000 {
-			compatible = "brcm,iproc-nsp-gpio", "brcm,iproc-gpio";
-			reg = <0x30000 0x50>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			ngpios = <4>;
-			interrupt-controller;
-			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		pwm: pwm at 31000 {
-			compatible = "brcm,iproc-pwm";
-			reg = <0x31000 0x28>;
-			clocks = <&osc>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-
-		rng: rng at 33000 {
-			compatible = "brcm,bcm-nsp-rng";
-			reg = <0x33000 0x14>;
-		};
-
 		qspi: qspi at 27200 {
 			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
 			reg = <0x027200 0x184>,
@@ -293,6 +270,29 @@
 			#size-cells = <0>;
 		};
 
+		gpiob: gpio at 30000 {
+			compatible = "brcm,iproc-nsp-gpio", "brcm,iproc-gpio";
+			reg = <0x30000 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			ngpios = <4>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pwm: pwm at 31000 {
+			compatible = "brcm,iproc-pwm";
+			reg = <0x31000 0x28>;
+			clocks = <&osc>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		rng: rng at 33000 {
+			compatible = "brcm,bcm-nsp-rng";
+			reg = <0x33000 0x14>;
+		};
+
 		ccbtimer0: timer at 34000 {
 			compatible = "arm,sp804";
 			reg = <0x34000 0x1000>;
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index a21b0fd..7afd845 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -65,7 +65,6 @@
 	status = "okay";
 };
 
-
 &amac1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index be7f2f8..9da18cd 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -65,7 +65,6 @@
 	status = "okay";
 };
 
-
 &amac1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 959cde9..4492f55 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -59,6 +59,8 @@
 	};
 };
 
+/* XHCI, MMC, and Ethernet support needed to be complete */
+
 &i2c0 {
 	temperature-sensor at 4c {
 		compatible = "adi,adt7461a";
@@ -115,12 +117,6 @@
 	};
 };
 
-/* XHCI, MMC, and Ethernet support needed to be complete */
-
-&uart0 {
-	status = "okay";
-};
-
 &pcie0 {
 	status = "okay";
 };
@@ -129,6 +125,15 @@
 	status = "okay";
 };
 
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_sel>;
+	nand_sel: nand_sel {
+		function = "nand";
+		groups = "nand_grp";
+	};
+};
+
 &sata_phy0 {
 	status = "okay";
 };
@@ -141,11 +146,6 @@
 	status = "okay";
 };
 
-&pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_sel>;
-	nand_sel: nand_sel {
-		function = "nand";
-		groups = "nand_grp";
-	};
+&uart0 {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 4ceb8fe..32ea59a 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -120,6 +120,14 @@
 	};
 };
 
+&sata_phy0 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
 &srab {
 	compatible = "brcm,bcm58623-srab", "brcm,nsp-srab";
 	status = "okay";
@@ -165,14 +173,6 @@
 	};
 };
 
-&sata_phy0 {
-	status = "okay";
-};
-
-&sata {
-	status = "okay";
-};
-
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 4420025..e7a4cb1 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -1,7 +1,7 @@
 /*
  *  BSD LICENSE
  *
- *  Copyright (c) 2016 Broadcom.  All rights reserved.
+ *  Copyright(c) 2016 Broadcom.  All rights reserved.
  *
  *  Redistribution and use in source and binary forms, with or without
  *  modification, are permitted provided that the following conditions
@@ -59,6 +59,10 @@
 	};
 };
 
+&amac0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -97,10 +101,6 @@
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &pcie0 {
 	status = "okay";
 };
@@ -118,7 +118,15 @@
 	};
 };
 
-&amac0 {
+&sata_phy0 {
+	status = "okay";
+};
+
+&sata_phy1 {
+	status = "okay";
+};
+
+&sata {
 	status = "okay";
 };
 
@@ -167,14 +175,6 @@
 	};
 };
 
-&sata_phy0 {
-	status = "okay";
-};
-
-&sata_phy1 {
-	status = "okay";
-};
-
-&sata {
+&uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 59d96fb..98337d6 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -53,14 +53,6 @@
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
 &amac0 {
 	status = "okay";
 };
@@ -69,30 +61,6 @@
 	status = "okay";
 };
 
-&pcie0 {
-	status = "okay";
-};
-
-&pcie1 {
-	status = "okay";
-};
-
-&pcie2 {
-	status = "okay";
-};
-
-&sata_phy0 {
-	status = "okay";
-};
-
-&sata_phy1 {
-	status = "okay";
-};
-
-&sata {
-	status = "okay";
-};
-
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -131,6 +99,18 @@
 	};
 };
 
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
+
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_sel>;
@@ -173,3 +153,23 @@
 		};
 	};
 };
+
+&sata_phy0 {
+	status = "okay";
+};
+
+&sata_phy1 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
2.7.4
