From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 25 Jul 2017 18:06:12 -0400
Subject: [PATCH 3/3] ARM: dts: NSP: Add USB3 and USB3 PHY to NSP
In-Reply-To: <1501020372-19607-1-git-send-email-jon.mason@broadcom.com>
References: <1501020372-19607-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1501020372-19607-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uses the existing Northstar USB3 PHY driver to enable the USB3
ports on NSP.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm958522er.dts  |  8 ++++++++
 arch/arm/boot/dts/bcm958525er.dts  |  8 ++++++++
 arch/arm/boot/dts/bcm958525xmc.dts |  8 ++++++++
 arch/arm/boot/dts/bcm958622hr.dts  |  8 ++++++++
 arch/arm/boot/dts/bcm958623hr.dts  |  8 ++++++++
 arch/arm/boot/dts/bcm958625hr.dts  |  8 ++++++++
 arch/arm/boot/dts/bcm958625k.dts   |  8 ++++++++
 8 files changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 770aa2e7970c..8ba53b834cc8 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -303,6 +303,16 @@
 			#size-cells = <0>;
 		};
 
+		xhci: usb at 29000 {
+			compatible = "generic-xhci";
+			reg = <0x29000 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb3_phy>;
+			phy-names = "usb3-phy";
+			dma-coherent;
+			status = "disabled";
+		};
+
 		ehci0: usb at 2a000 {
 			compatible = "generic-ehci";
 			reg = <0x2a000 0x100>;
@@ -471,6 +481,15 @@
 				phy-names = "sata-phy";
 			};
 		};
+
+		usb3_phy: usb3-phy at 104000 {
+			compatible = "brcm,ns-bx-usb3-phy";
+			reg = <0x104000 0x1000>,
+			      <0x032000 0x1000>;
+			reg-names = "dmp", "ccb-mii";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 
 	pcie0: pcie at 18012000 {
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index f5c42962c201..f9dd342cc2ae 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -170,3 +170,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index efcb1f67bdad..374508a9cfbf 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -182,3 +182,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index b335ce02e32f..403250c5ad8e 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -202,3 +202,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index 16ab2d82a14b..fd8b8c689ffe 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -219,3 +219,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 9b921c6aa8f8..3bc50849d013 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -227,3 +227,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 006b08e41a3b..d94d14b3c745 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -229,3 +229,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 64740f85cf4c..2cf2392483b2 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -264,3 +264,11 @@
 &uart1 {
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
-- 
2.7.4
