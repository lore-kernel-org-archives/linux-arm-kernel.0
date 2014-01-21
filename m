From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 21 Jan 2014 12:56:54 +0200
Subject: [PATCHv3 22/41] ARM: omap2.dtsi: add omapdss information
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1390301833-24944-23-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT data for OMAP2 display subsystem, which contains the following
blocks:

dss - the wrapper/glue for the display modules
dispc - display controller
rfbi - MIPI DBI encoder
venc - analog TV encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index d0c5b37e248c..af3531cc4576 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -271,5 +271,36 @@
 			ti,hwmods = "timer12";
 			ti,timer-pwm;
 		};
+
+		dss: dss at 48050000 {
+			compatible = "ti,omap2-dss", "simple-bus";
+			reg = <0x48050000 0x400>;
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc at 48050400 {
+				compatible = "ti,omap2-dispc";
+				reg = <0x48050400 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			rfbi: encoder at 48050800 {
+				compatible = "ti,omap2-rfbi";
+				reg = <0x48050800 0x400>;
+				status = "disabled";
+				ti,hwmods = "dss_rfbi";
+			};
+
+			venc: encoder at 48050c00 {
+				compatible = "ti,omap2-venc";
+				reg = <0x48050c00 0x400>;
+				status = "disabled";
+				ti,hwmods = "dss_venc";
+			};
+		};
 	};
 };
-- 
1.8.3.2
