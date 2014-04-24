From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Apr 2014 13:17:07 +0300
Subject: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3b99ec25b748..9e7581eaeb23 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -434,6 +434,13 @@
 	pinctrl-0 = <&i2c5_pins>;
 
 	clock-frequency = <400000>;
+
+	tca6424a: tca6424a at 22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &mcbsp3 {
-- 
1.9.1
