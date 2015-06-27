From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Jun 2015 17:51:13 -0300
Subject: [PATCH] ARM: dts: imx27: Adjust the GPT compatible string
Message-ID: <1435438273-19741-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

include/soc/imx/timer.h describes well the different versions of 
the GPT block among the imx family:

enum imx_gpt_type {
	GPT_TYPE_IMX1,		/* i.MX1 */
	GPT_TYPE_IMX21,		/* i.MX21/27 */
	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
};

So the proper compatible string for the MX27 case should be 
"fsl,imx21-gpt".

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index bc215e4b..b69be5c 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -108,7 +108,7 @@
 			};
 
 			gpt1: timer at 10003000 {
-				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
 				reg = <0x10003000 0x1000>;
 				interrupts = <26>;
 				clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
@@ -117,7 +117,7 @@
 			};
 
 			gpt2: timer at 10004000 {
-				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
 				reg = <0x10004000 0x1000>;
 				interrupts = <25>;
 				clocks = <&clks IMX27_CLK_GPT2_IPG_GATE>,
@@ -126,7 +126,7 @@
 			};
 
 			gpt3: timer at 10005000 {
-				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
 				reg = <0x10005000 0x1000>;
 				interrupts = <24>;
 				clocks = <&clks IMX27_CLK_GPT3_IPG_GATE>,
@@ -376,7 +376,7 @@
 			};
 
 			gpt4: timer at 10019000 {
-				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
 				reg = <0x10019000 0x1000>;
 				interrupts = <4>;
 				clocks = <&clks IMX27_CLK_GPT4_IPG_GATE>,
@@ -385,7 +385,7 @@
 			};
 
 			gpt5: timer at 1001a000 {
-				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
 				reg = <0x1001a000 0x1000>;
 				interrupts = <3>;
 				clocks = <&clks IMX27_CLK_GPT5_IPG_GATE>,
@@ -436,7 +436,7 @@
 			};
 
 			gpt6: timer at 1001f000 {
-				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+				compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
 				reg = <0x1001f000 0x1000>;
 				interrupts = <2>;
 				clocks = <&clks IMX27_CLK_GPT6_IPG_GATE>,
-- 
1.9.1
