From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  7 May 2014 15:52:23 +0200
Subject: [PATCHv4 17/20] ARM: mvebu: add Device Tree description of the EHCI
 controller on Armada 38x
In-Reply-To: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399470746-2948-18-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The Marvell Armada 38x SoCs contains one EHCI controller. This commit
adds the Device Tree description of this interface at the SoC level,
and also enables the USB2 port on the Armada 385 DB platform.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts | 4 ++++
 arch/arm/boot/dts/armada-38x.dtsi   | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index d5db146..91e3e44 100644
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
index 6f97f3d..fa2501d 100644
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
1.9.2
