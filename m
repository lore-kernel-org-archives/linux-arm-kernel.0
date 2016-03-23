From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 23 Mar 2016 16:52:47 +0100
Subject: [PATCH dt] ARM: BCM5301X: Set vcc-gpio for USB controllers of few
 devices
Message-ID: <1458748367-18294-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are few devices that have USB power controlled using GPIO. Linux
USB host driver (bcma-hcd) already supports this by reading vcc-gpio
from DT. Set it properly for all known devices.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts |  8 ++++++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts       | 15 ++++-----------
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts |  5 +++++
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts       |  8 ++++++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts     |  4 ++++
 arch/arm/boot/dts/bcm5301x.dtsi                   | 14 ++++++++++++++
 6 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index 42dcdfb..fb62ed6 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -139,3 +139,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb2 {
+	vcc-gpio = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index ca92bba..6bebfa6 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -24,17 +24,6 @@
 		reg = <0x00000000 0x08000000>;
 	};
 
-	axi at 18000000 {
-		usb3 at 23000 {
-			reg = <0x00023000 0x1000>;
-
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -97,3 +86,7 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb3 {
+	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index 2a92e8d..791d722 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -126,3 +126,8 @@
 		};
 	};
 };
+
+
+&usb2 {
+	vcc-gpio = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index b52927c..ca18151 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -106,3 +106,11 @@
 		};
 	};
 };
+
+&usb2 {
+	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 6c83538..9205c03 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -109,3 +109,7 @@
 	status = "okay";
 	clock-frequency = <125000000>;
 };
+
+&usb3 {
+	vcc-gpio = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 65a1309..b3e9d28 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -207,6 +207,20 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		usb2: usb2 at 21000 {
+			reg = <0x00021000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		usb3: usb3 at 23000 {
+			reg = <0x00023000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 
 	lcpll0: lcpll0 at 1800c100 {
-- 
1.8.4.5
