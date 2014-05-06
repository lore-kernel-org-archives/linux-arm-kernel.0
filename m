From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  6 May 2014 02:14:15 +0200
Subject: [PATCH v3 20/20] ARM: mvebu: Add Device Tree description of the EHCI
 host on Armada 375
In-Reply-To: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1399335255-589-21-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 375 SoCs contains one EHCI host. This commit adds
the Device Tree description of this interfaces at the SoC level, and
also enables the USB2 port on the Armada 375 DB platform.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts |  4 ++++
 arch/arm/boot/dts/armada-375.dtsi   | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 0453d69e6433..01bc5e87898b 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -102,6 +102,10 @@
 				};
 			};
 
+			usb at 54000 {
+				status = "okay";
+			};
+
 			usb3 at 58000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 1b81d1e33510..d2b19bfe7496 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,24 @@
 				clocks = <&coreclk 0>;
 			};
 
+			usb at 50000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x50000 0x500>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 18>;
+				phys = <&usbcluster 0>;
+				phy-names="usb";
+				status = "disabled";
+			};
+
+			usb at 54000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x54000 0x500>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+
 			usb3 at 58000 {
 				compatible = "marvell,armada-375-xhci";
 				reg = <0x58000 0x20000>,<0x5b880 0x80>;
-- 
1.8.1.2
