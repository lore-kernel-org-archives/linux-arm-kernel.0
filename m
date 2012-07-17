From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 17 Jul 2012 13:40:06 +0530
Subject: [PATCH v2 06/11] arm/dts: Add twl6030-usb data
In-Reply-To: <1342512611-20529-1-git-send-email-kishon@ti.com>
References: <1342512611-20529-1-git-send-email-kishon@ti.com>
Message-ID: <1342512611-20529-7-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add twl6030-usb data node in twl6030 device tree file

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |    4 ++++
 arch/arm/boot/dts/omap4-sdp.dts   |    4 ++++
 arch/arm/boot/dts/twl6030.dtsi    |    6 ++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 1efe0c5..7052422 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -89,3 +89,7 @@
 	ti,non-removable;
 	bus-width = <4>;
 };
+
+&twlusb {
+	usb-supply = <&vusb>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index d08c4d1..6326d7c 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -158,3 +158,7 @@
 	bus-width = <4>;
 	ti,non-removable;
 };
+
+&twlusb {
+	usb-supply = <&vusb>;
+};
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 3b2f351..5efd6d3 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -83,4 +83,10 @@
 	clk32kg: regulator at 12 {
 		compatible = "ti,twl6030-clk32kg";
 	};
+
+	twlusb: twl6030-usb {
+		compatible = "ti,twl6030-usb";
+		interrupts = < 4 10 >;
+		regulator = "vusb";
+	};
 };
-- 
1.7.5.4
