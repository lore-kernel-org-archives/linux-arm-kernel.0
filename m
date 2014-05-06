From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  6 May 2014 02:14:14 +0200
Subject: [PATCH v3 19/20] ARM: mvebu: Add Device Tree description of the xHCI
 host on Armada 375
In-Reply-To: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1399335255-589-20-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 375 SoCs contain a xHCI host. This commit adds the
Device Tree description of this interfaces at the SoC level, and also
enables the USB3 port on the Armada 375 DB platform.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts |  4 ++++
 arch/arm/boot/dts/armada-375.dtsi   | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 9378d3136b41..0453d69e6433 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -102,6 +102,10 @@
 				};
 			};
 
+			usb3 at 58000 {
+				status = "okay";
+			};
+
 			mvsdio at d4000 {
 				pinctrl-0 = <&sdio_pins &sdio_st_pins>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 6724c10a8862..1b81d1e33510 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,16 @@
 				clocks = <&coreclk 0>;
 			};
 
+			usb3 at 58000 {
+				compatible = "marvell,armada-375-xhci";
+				reg = <0x58000 0x20000>,<0x5b880 0x80>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 16>;
+				phys = <&usbcluster 1>;
+				phy-names="usb";
+				status = "disabled";
+			};
+
 			usbcluster: usb-cluster at 18400 {
 				compatible = "marvell,armada-375-usb-cluster";
 				reg = <0x18400 0x4>;
-- 
1.8.1.2
