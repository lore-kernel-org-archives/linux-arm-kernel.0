From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:08:57 +0100
Subject: [PATCH 2/7] ARM: i.MX27: Add GPT devicetree nodes
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1363262942-26702-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPT is the GPT timer found on i.MX SoCs.

This adds the missing GPT devicetree nodes. Also fixup the watchdog
register map size along the way. it's 0x1000, not 0x4000. This didn't
hurt before as the region was not occupied by another device, but now
overlaps with the GPT.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsip | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsip b/arch/arm/boot/dts/imx27.dtsip
index 324130f..3e0585f 100644
--- a/arch/arm/boot/dts/imx27.dtsip
+++ b/arch/arm/boot/dts/imx27.dtsip
@@ -60,10 +60,28 @@
 
 			wdog: wdog at 10002000 {
 				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
-				reg = <0x10002000 0x4000>;
+				reg = <0x10002000 0x1000>;
 				interrupts = <27>;
 			};
 
+			gpt1: timer at 10003000 {
+				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				reg = <0x10003000 0x1000>;
+				interrupts = <26>;
+			};
+
+			gpt2: timer at 10004000 {
+				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				reg = <0x10004000 0x1000>;
+				interrupts = <25>;
+			};
+
+			gpt3: timer at 10005000 {
+				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				reg = <0x10005000 0x1000>;
+				interrupts = <24>;
+			};
+
 			uart1: serial at 1000a000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
@@ -188,6 +206,18 @@
 				status = "disabled";
 			};
 
+			gpt4: timer at 10019000 {
+				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				reg = <0x10019000 0x1000>;
+				interrupts = <4>;
+			};
+
+			gpt5: timer at 1001a000 {
+				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				reg = <0x1001a000 0x1000>;
+				interrupts = <3>;
+			};
+
 			uart5: serial at 1001b000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1001b000 0x1000>;
@@ -211,6 +241,11 @@
 				status = "disabled";
 			};
 
+			gpt6: timer at 1001f000 {
+				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				reg = <0x1001f000 0x1000>;
+				interrupts = <2>;
+			};
 		};
 
 		aipi at 10020000 { /* AIPI2 */
-- 
1.8.2.rc2
