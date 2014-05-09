From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 14:56:18 +0300
Subject: [PATCH 10/11] ARM: dts: omap5-uevm.dts: add tca6424a
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1399636579-8062-11-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3b99ec25b748..76877516f6df 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -434,6 +434,13 @@
 	pinctrl-0 = <&i2c5_pins>;
 
 	clock-frequency = <400000>;
+
+	gpio9: gpio at 22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &mcbsp3 {
-- 
1.9.1
