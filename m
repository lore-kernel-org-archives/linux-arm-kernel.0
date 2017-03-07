From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  7 Mar 2017 18:34:04 -0500
Subject: [PATCH] ARM: dts: NSP: Add EHCI/OHCI USB nodes to device tree
Message-ID: <1488929644-30321-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EHCI and OHCI entries to the Northstar Plus device tree files.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 14 ++++++++++++++
 arch/arm/boot/dts/bcm958522er.dts  | 10 +++++++++-
 arch/arm/boot/dts/bcm958525er.dts  | 10 +++++++++-
 arch/arm/boot/dts/bcm958525xmc.dts |  8 ++++++++
 arch/arm/boot/dts/bcm958622hr.dts  | 10 +++++++++-
 arch/arm/boot/dts/bcm958623hr.dts  | 10 +++++++++-
 arch/arm/boot/dts/bcm958625hr.dts  |  8 ++++++++
 arch/arm/boot/dts/bcm958625k.dts   |  8 ++++++++
 arch/arm/boot/dts/bcm988312hr.dts  | 10 +++++++++-
 9 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 832795b..fbc1d1d 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -306,6 +306,20 @@
 			status = "disabled";
 		};
 
+		ehci0: usb at 2a000 {
+			compatible = "generic-ehci";
+			reg = <0x2a000 0x100>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		ohci0: usb at 2b000 {
+			compatible = "generic-ohci";
+			reg = <0x2b000 0x100>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		rng: rng at 33000 {
 			compatible = "brcm,bcm-nsp-rng";
 			reg = <0x33000 0x14>;
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index df05e7f..f5c4296 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -60,7 +60,7 @@
 	};
 };
 
-/* USB 2/3 support needed to be complete */
+/* USB 3 support needed to be complete */
 
 &amac0 {
 	status = "okay";
@@ -70,6 +70,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -108,6 +112,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index 4a3ab19..efcb1f6 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -60,7 +60,7 @@
 	};
 };
 
-/* USB 2/3 support needed to be complete */
+/* USB 3 support needed to be complete */
 
 &amac0 {
 	status = "okay";
@@ -70,6 +70,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -108,6 +112,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 81f7843..23f23bd 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -66,6 +66,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &i2c0 {
 	temperature-sensor at 4c {
 		compatible = "adi,adt7461a";
@@ -122,6 +126,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index c88b8fe..16ab2d8 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -60,7 +60,7 @@
 	};
 };
 
-/* USB 2/3 and SLIC support needed to be complete */
+/* USB 3 and SLIC support needed to be complete */
 
 &amac0 {
 	status = "okay";
@@ -74,6 +74,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -112,6 +116,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index d503fa0..9b921c6 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -60,7 +60,7 @@
 	};
 };
 
-/* USB 2/3 and SLIC support needed to be complete */
+/* USB 3 and SLIC support needed to be complete */
 
 &amac0 {
 	status = "okay";
@@ -74,6 +74,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -112,6 +116,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index cc0363b..006b08e 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -72,6 +72,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -110,6 +114,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index f8d47e5..64740f8 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -65,6 +65,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -103,6 +107,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index 74e15a3..bce251a 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -60,7 +60,7 @@
 	};
 };
 
-/* USB 2/3 support needed to be complete */
+/* USB 3 support needed to be complete */
 
 &amac0 {
 	status = "okay";
@@ -74,6 +74,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -112,6 +116,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
-- 
2.7.4
