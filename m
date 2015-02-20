From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 18:04:21 +0100
Subject: [PATCHv2 02/15] ARM: mvebu: fix usb@ unit address on Armada 38x to
 match register address
In-Reply-To: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1424451874-25375-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Armada 38x, the USB2 controller registers are at 0x58000,
so the corresponding Device Tree node should have a unit address of
58000, and not 50000. We were using 50000 due to an incorrect
copy/pastebin of Armada 370/XP code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-db.dts | 2 +-
 arch/arm/boot/dts/armada-388-gp.dts | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 16512ef..af6c74e 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -99,7 +99,7 @@
 				phy-mode = "rgmii-id";
 			};
 
-			usb at 50000 {
+			usb at 58000 {
 				status = "ok";
 			};
 
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 590b383..3ff0573 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -135,7 +135,7 @@
 			};
 
 			/* CON4 */
-			usb at 50000 {
+			usb at 58000 {
 				vcc-supply = <&reg_usb2_0_vbus>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 54ebce7..96d7cf0 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -435,7 +435,7 @@
 				status = "disabled";
 			};
 
-			usb at 50000 {
+			usb at 58000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x58000 0x500>;
 				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.0
