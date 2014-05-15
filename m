From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 May 2014 12:17:41 +0200
Subject: [PATCH v6 16/17] ARM: mvebu: add Device Tree description of the xHCI
 controller on Armada 375
In-Reply-To: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400149062-32661-17-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 375 SoCs contain a xHCI controller. This commit
adds the Device Tree description of this interfaces at the SoC level,
and also enables the USB3 port on the Armada 375 DB platform.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 4 ++++
 arch/arm/boot/dts/armada-375.dtsi   | 8 ++++++++
 2 files changed, 12 insertions(+)

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
index 3877693fb2d8..7b303ecc2490 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,14 @@
 				clocks = <&coreclk 0>;
 			};
 
+			usb3 at 58000 {
+				compatible = "marvell,armada-375-xhci";
+				reg = <0x58000 0x20000>,<0x5b880 0x80>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 16>;
+				status = "disabled";
+			};
+
 			xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.8.1.2
