From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 23 Aug 2012 12:29:12 +0300
Subject: [PATCH 5/6] ARM/dts: OMAP5: Add McBSP entries
In-Reply-To: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
References: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1345714153-13094-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create the sections describing the McBSP ports to be able to use them via
DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 57e5270..c5f9242 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -180,5 +180,41 @@
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 		};
+
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
 	};
 };
-- 
1.7.8.6
