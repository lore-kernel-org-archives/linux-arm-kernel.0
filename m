From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 1 Nov 2012 10:49:27 -0500
Subject: [PATCH 3/3] ARM: dts: Add OMAP5 counter node
In-Reply-To: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
References: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1351784967-32520-4-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 32kHz counter node for OMAP5 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index c8954f1..ead74c8 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -77,6 +77,12 @@
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
+		counter32k: counter at 4ae04000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4ae04000 0x40>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap5_pmx_core: pinmux at 4a002840 {
 			compatible = "ti,omap4-padconf", "pinctrl-single";
 			reg = <0x4a002840 0x01b6>;
-- 
1.7.9.5
