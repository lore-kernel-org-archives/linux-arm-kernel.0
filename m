From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  5 Sep 2012 14:58:52 +0300
Subject: [PATCH v3 4/8] ARM/dts: omap4: Add McBSP entries
In-Reply-To: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346846336-27321-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create the sections describing the McBSP ports to be able to use them via
DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 1853dc7..5ed3b94 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -287,6 +287,53 @@
 			ti,hwmods = "dmic";
 		};
 
+		mcbsp1: mcbsp at 40122000 {
+			compatible = "ti,omap4-mcbsp";
+			reg = <0x40122000 0xff>, /* MPU private access */
+			      <0x49022000 0xff>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
+			interrupts = <0 17 0x4>;
+			interrupt-names = "common";
+			interrupt-parent = <&gic>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp1";
+		};
+
+		mcbsp2: mcbsp at 40124000 {
+			compatible = "ti,omap4-mcbsp";
+			reg = <0x40124000 0xff>, /* MPU private access */
+			      <0x49024000 0xff>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
+			interrupts = <0 22 0x4>;
+			interrupt-names = "common";
+			interrupt-parent = <&gic>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp2";
+		};
+
+		mcbsp3: mcbsp at 40126000 {
+			compatible = "ti,omap4-mcbsp";
+			reg = <0x40126000 0xff>, /* MPU private access */
+			      <0x49026000 0xff>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
+			interrupts = <0 23 0x4>;
+			interrupt-names = "common";
+			interrupt-parent = <&gic>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp3";
+		};
+
+		mcbsp4: mcbsp at 48096000 {
+			compatible = "ti,omap4-mcbsp";
+			reg = <0x48096000 0xff>; /* L4 Interconnect */
+			reg-names = "mpu";
+			interrupts = <0 16 0x4>;
+			interrupt-names = "common";
+			interrupt-parent = <&gic>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp4";
+		};
+
 		keypad: keypad at 4a31c000 {
 			compatible = "ti,omap4-keypad";
 			ti,hwmods = "kbd";
-- 
1.7.12
