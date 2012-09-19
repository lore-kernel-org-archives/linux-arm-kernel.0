From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 19 Sep 2012 15:02:06 +0530
Subject: [PATCH v3 1/3] ARM: dts: Add twl6030-usb data
In-Reply-To: <1348047128-25692-1-git-send-email-kishon@ti.com>
References: <1348047128-25692-1-git-send-email-kishon@ti.com>
Message-ID: <1348047128-25692-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add twl6030-usb data node in twl6030 device tree file. twl6030-usb is the
comparator driver for USB that detects VBUS and ID events. The dt data is
comprised of two interrupts, one for ID and one for VBUS and a phandle to the
regulator.

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |    4 ++++
 arch/arm/boot/dts/omap4-sdp.dts   |    4 ++++
 arch/arm/boot/dts/twl6030.dtsi    |    5 +++++
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 20b966e..6640fd9 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -137,3 +137,7 @@
 	cs1-used;
 	device-handle = <&elpida_ECB240ABACN>;
 };
+
+&twl_usb_comparator {
+	usb-supply = <&vusb>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 94a23b3..406dab1 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -349,3 +349,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins>;
 };
+
+&twl_usb_comparator {
+	usb-supply = <&vusb>;
+};
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 123e2c4..9996cfc 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -86,4 +86,9 @@
 	clk32kg: regulator-clk32kg {
 		compatible = "ti,twl6030-clk32kg";
 	};
+
+	twl_usb_comparator: usb-comparator {
+		compatible = "ti,twl6030-usb";
+		interrupts = <4>, <10>;
+	};
 };
-- 
1.7.9.5
