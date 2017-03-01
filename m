From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  1 Mar 2017 18:02:28 -0500
Subject: [PATCH] ARM: dts: NSP: GPIO reboot open-source
Message-ID: <1488409348-6371-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The libgpio code pre-sets the GPIO values for the gpio-reset in the
device tree.  This results in the device being reset during bringup.
To prevent this pre-setting, use the "open-source" flag in the device
tree.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: b1aaf88 ("ARM: dts: NSP: Add GPIO reboot method to bcm958625hr DTS file")
Fixes: 10baed1 ("ARM: dts: NSP: Add GPIO reboot method to bcm958625xmc DTS file")
Fixes: 088e3148 ("ARM: dts: NSP: Add new DT file for bcm958522er")
Fixes: e3227c1 ("ARM: dts: NSP: Add new DT file for bcm958525er")
Fixes: 2f8bc00 ("ARM: dts: NSP: Add new DT file for bcm958622hr")
Fixes: d454c37 ("ARM: dts: NSP: Add new DT file for bcm958623hr")
Fixes: f27eacf ("ARM: dts: NSP: Add new DT file for bcm988312hr")
---
 arch/arm/boot/dts/bcm958522er.dts  | 1 +
 arch/arm/boot/dts/bcm958525er.dts  | 1 +
 arch/arm/boot/dts/bcm958525xmc.dts | 1 +
 arch/arm/boot/dts/bcm958622hr.dts  | 1 +
 arch/arm/boot/dts/bcm958623hr.dts  | 1 +
 arch/arm/boot/dts/bcm958625hr.dts  | 1 +
 arch/arm/boot/dts/bcm988312hr.dts  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index 3f04a40..df05e7f 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -55,6 +55,7 @@
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+		open-source;
 		priority = <200>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index 9fd5422..4a3ab19 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -55,6 +55,7 @@
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+		open-source;
 		priority = <200>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 41e7fd3..81f7843 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -55,6 +55,7 @@
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpioa 31 GPIO_ACTIVE_LOW>;
+		open-source;
 		priority = <200>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index 477c486..c88b8fe 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -55,6 +55,7 @@
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+		open-source;
 		priority = <200>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index c0a499d..d503fa0 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -55,6 +55,7 @@
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+		open-source;
 		priority = <200>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index f7eb585..cc0363b 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -55,6 +55,7 @@
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+		open-source;
 		priority = <200>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index 16666324..74e15a3 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -55,6 +55,7 @@
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+		open-source;
 		priority = <200>;
 	};
 };
-- 
2.7.4
