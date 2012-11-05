From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 5 Nov 2012 18:22:51 +0530
Subject: [PATCH V3 2/3] ARM: dts: omap5: EMIF device tree data for OMAP5 boards
In-Reply-To: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
References: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1352119972-13710-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding EMIF device tree data for OMAP5 boards.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index ead74c8..790bb2a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -474,5 +474,27 @@
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
 		};
+
+		emif1: emif at 0x4c000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif1";
+			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
+			reg = <0x4c000000 0x400>;
+			interrupts = <0 110 0x4>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
+		emif2: emif at 0x4d000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif2";
+			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
+			reg = <0x4d000000 0x400>;
+			interrupts = <0 111 0x4>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
 	};
 };
-- 
1.7.9.5
