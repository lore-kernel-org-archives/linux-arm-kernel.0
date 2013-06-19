From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Jun 2013 18:56:19 +0200
Subject: [PATCHv3 11/11] arm: mvebu: link PCIe controllers to the MSI
 controller
In-Reply-To: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1371660979-21588-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adjusts the Armada 370 and Armada XP PCIe controllers
Device Tree informations to reference their MSI controller. In the
case of this platform, the MSI controller is implemented by the MPIC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi        | 1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..a60018d 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -178,6 +178,7 @@
 				#address-cells = <3>;
 				#size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index f8eaa38..4a9a305 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -91,6 +91,7 @@
 #address-cells = <3>;
 #size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index f4029f0..bc63783 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -111,6 +111,7 @@
 				#address-cells = <3>;
 				#size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index c7b1f4d..77db2bc 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -127,6 +127,7 @@
 				#address-cells = <3>;
 				#size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
-- 
1.8.1.2
