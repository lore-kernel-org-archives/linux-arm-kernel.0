From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 29 Aug 2012 16:31:07 +0300
Subject: [PATCH v2 8/8] ARM/dts: omap5: Add McPDM and DMIC section to the dtsi
 file
In-Reply-To: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346247067-9632-9-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to load the McPDM and DMIC driver when booted with device tree.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 57ca7c1..5ab1a36 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -212,6 +212,26 @@
 			ti,needs-special-reset;
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
1.7.8.6
