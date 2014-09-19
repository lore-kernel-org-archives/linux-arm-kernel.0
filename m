From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 19 Sep 2014 22:14:37 +0200
Subject: [PATCH 1/8] ARM: mvebu: armada-xp: Consolidate pinctrl node
In-Reply-To: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411157684-6991-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All current Armada XP SoCs have their pin controller at 0x18000/0x38.
Move the common properties of pinctrl nodes to armada-xp.dtsi to allow
to share pinctrl settings later.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |  7 -------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |  7 -------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |  7 -------
 arch/arm/boot/dts/armada-xp.dtsi         | 10 ++++++++++
 4 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 2592e1c13560..b5933aa9ab50 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -169,13 +169,6 @@
 		internal-regs {
 			pinctrl {
 				compatible = "marvell,mv78230-pinctrl";
-				reg = <0x18000 0x38>;
-
-				sdio_pins: sdio-pins {
-					marvell,pins = "mpp30", "mpp31", "mpp32",
-						       "mpp33", "mpp34", "mpp35";
-					marvell,function = "sd0";
-				};
 			};
 
 			gpio0: gpio at 18100 {
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 480e237a870f..5954b362180c 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -253,13 +253,6 @@
 		internal-regs {
 			pinctrl {
 				compatible = "marvell,mv78260-pinctrl";
-				reg = <0x18000 0x38>;
-
-				sdio_pins: sdio-pins {
-					marvell,pins = "mpp30", "mpp31", "mpp32",
-						       "mpp33", "mpp34", "mpp35";
-					marvell,function = "sd0";
-				};
 			};
 
 			gpio0: gpio at 18100 {
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 2c7b1fef4703..735924d62e12 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -291,13 +291,6 @@
 		internal-regs {
 			pinctrl {
 				compatible = "marvell,mv78460-pinctrl";
-				reg = <0x18000 0x38>;
-
-				sdio_pins: sdio-pins {
-					marvell,pins = "mpp30", "mpp31", "mpp32",
-						       "mpp33", "mpp34", "mpp35";
-					marvell,function = "sd0";
-				};
 			};
 
 			gpio0: gpio at 18100 {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bff9f6c18db1..75653774342a 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -71,6 +71,16 @@
 				status = "disabled";
 			};
 
+			pinctrl {
+				reg = <0x18000 0x38>;
+
+				sdio_pins: sdio-pins {
+					marvell,pins = "mpp30", "mpp31", "mpp32",
+						       "mpp33", "mpp34", "mpp35";
+					marvell,function = "sd0";
+				};
+			};
+
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0x18200 0x500>;
-- 
2.0.0
