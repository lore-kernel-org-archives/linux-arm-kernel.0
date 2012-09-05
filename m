From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  5 Sep 2012 14:58:55 +0300
Subject: [PATCH v3 7/8] ARM/dts: omap5: Add McPDM and DMIC section to the dtsi
 file
In-Reply-To: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346846336-27321-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to load the McPDM and DMIC driver when booted with device tree.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index aa97e93..9ac75b3 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -252,6 +252,26 @@
 			ti,hwmods = "kbd";
 		};
 
+		mcpdm: mcpdm at 40132000 {
+			compatible = "ti,omap4-mcpdm";
+			reg = <0x40132000 0x7f>, /* MPU private access */
+			      <0x49032000 0x7f>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
+			interrupts = <0 112 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "mcpdm";
+		};
+
+		dmic: dmic at 4012e000 {
+			compatible = "ti,omap4-dmic";
+			reg = <0x4012e000 0x7f>, /* MPU private access */
+			      <0x4902e000 0x7f>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
+			interrupts = <0 114 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "dmic";
+		};
+
 		mcbsp1: mcbsp at 40122000 {
 			compatible = "ti,omap4-mcbsp";
 			reg = <0x40122000 0xff>, /* MPU private access */
-- 
1.7.12
