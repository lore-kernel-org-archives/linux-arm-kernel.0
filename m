From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 11 Oct 2012 18:17:48 +0530
Subject: [PATCH V2 2/3] ARM: dts: omap5: EMIF device tree data for OMAP5 boards
In-Reply-To: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1349959669-16366-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding EMIF device tree data for OMAP5 boards.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5db33f4..445aeea 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -319,5 +319,29 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
 		};
+
+		emif1: emif at 0x4c000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif1";
+			phy-type	= <2>;
+			reg = <0x4c000000 0x3ff>;
+			interrupts = <0 110 0x4>;
+			interrupt-parent = <&gic>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
+		emif2: emif at 0x4d000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif2";
+			phy-type	= <2>;
+			reg = <0x4d000000 0x3ff>;
+			interrupts = <0 111 0x4>;
+			interrupt-parent = <&gic>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
 	};
 };
-- 
1.7.10.4
