From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 May 2014 12:17:40 +0200
Subject: [PATCH v6 15/17] ARM: mvebu: add Device Tree description of the EHCI
 controller on Armada 38x
In-Reply-To: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400149062-32661-16-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x SoCs contains one EHCI controller. This commit
adds the Device Tree description of this interface at the SoC level,
and also enables the USB2 port on the Armada 385 DB platform.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts | 4 ++++
 arch/arm/boot/dts/armada-38x.dtsi   | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index d5db1466da82..91e3e449067f 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -65,6 +65,10 @@
 				phy-mode = "rgmii-id";
 			};
 
+			usb at 50000 {
+				status = "ok";
+			};
+
 			ethernet at 70000 {
 				status = "okay";
 				phy = <&phy0>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 6f97f3d7fb15..fa2501d62e44 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -283,6 +283,14 @@
 				status = "disabled";
 			};
 
+			usb at 50000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x58000 0x500>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 18>;
+				status = "disabled";
+			};
+
 			xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.8.1.2
