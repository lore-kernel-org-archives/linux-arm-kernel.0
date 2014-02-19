From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 19 Feb 2014 15:42:29 +0800
Subject: [PATCH v2 2/4] ARM: dts: vf610-twr: Enable SAI ALSA SoC DAI device
In-Reply-To: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
References: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1392795751-13351-3-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds and enables the SAI device.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/vf610-twr.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index e3a3805..bcee3bb 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -121,6 +121,18 @@
 			>;
 		};
 
+		pinctrl_sai2: sai2grp {
+		      fsl,pins = <
+				VF610_PAD_PTA16__SAI2_TX_BCLK		0x02ed
+				VF610_PAD_PTA18__SAI2_TX_DATA		0x02ee
+				VF610_PAD_PTA19__SAI2_TX_SYNC		0x02ed
+				VF610_PAD_PTA21__SAI2_RX_BCLK		0x02ed
+				VF610_PAD_PTA22__SAI2_RX_DATA		0x02ed
+				VF610_PAD_PTA23__SAI2_RX_SYNC		0x02ed
+				VF610_PAD_PTB18__EXT_AUDIO_MCLK		0x02ed
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				VF610_PAD_PTB4__UART1_TX		0x21a2
@@ -130,6 +142,12 @@
 	};
 };
 
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
1.8.4
