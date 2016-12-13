From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 13 Dec 2016 13:13:49 -0500
Subject: [PATCH 5/7] ARM: dts: NSP: Add and enable amac2
In-Reply-To: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
References: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1481652831-2744-6-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and enable the third AMAC ethernet interface in the device trees for
the platforms where it is present.  Also, enable amac1 on some of the
platforms where that was missing.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi    | 9 +++++++++
 arch/arm/boot/dts/bcm958622hr.dts | 8 ++++++++
 arch/arm/boot/dts/bcm958623hr.dts | 8 ++++++++
 arch/arm/boot/dts/bcm958625hr.dts | 8 ++++++++
 arch/arm/boot/dts/bcm958625k.dts  | 4 ++++
 arch/arm/boot/dts/bcm988312hr.dts | 8 ++++++++
 6 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 9cd77ab..ecffc16 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -227,6 +227,15 @@
 			status = "disabled";
 		};
 
+		amac2: ethernet at 24000 {
+			compatible = "brcm,nsp-amac";
+			reg = <0x024000 0x1000>,
+			      <0x112000 0x1000>;
+			reg-names = "amac_base", "idm_base";
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		nand: nand at 26000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x026000 0x600>,
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index 18b8ffb..477c486 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -65,6 +65,14 @@
 	status = "okay";
 };
 
+&amac1 {
+	status = "okay";
+};
+
+&amac2 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 61499ae..c0a499d 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -65,6 +65,14 @@
 	status = "okay";
 };
 
+&amac1 {
+	status = "okay";
+};
+
+&amac2 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 94cce23..f7eb585 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -63,6 +63,14 @@
 	status = "okay";
 };
 
+&amac1 {
+	status = "okay";
+};
+
+&amac2 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 7aa86c7..6e994f2 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -61,6 +61,10 @@
 	status = "okay";
 };
 
+&amac2 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index c324c9f..16666324 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -65,6 +65,14 @@
 	status = "okay";
 };
 
+&amac1 {
+	status = "okay";
+};
+
+&amac2 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
-- 
2.7.4
