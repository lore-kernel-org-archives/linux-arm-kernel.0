From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue,  3 Jan 2017 12:57:18 -0800
Subject: [PATCH v2 08/19] ARM: dts: imx6-sabreauto: add pinctrl for gpt input
 capture
In-Reply-To: <1483477049-19056-1-git-send-email-steve_longerbeam@mentor.com>
References: <1483477049-19056-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1483477049-19056-9-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl groups for both GPT input capture channels.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 516bac6..83ac2ff 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -457,6 +457,18 @@
 			>;
 		};
 
+		pinctrl_gpt_input_capture0: gptinputcapture0grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1	0x80000000
+			>;
+		};
+
+		pinctrl_gpt_input_capture1: gptinputcapture1grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT1__GPT_CAPTURE2	0x80000000
+			>;
+		};
+
 		pinctrl_spdif: spdifgrp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL3__SPDIF_IN 0x1b0b0
-- 
2.7.4
