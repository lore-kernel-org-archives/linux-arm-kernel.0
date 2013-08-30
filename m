From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 30 Aug 2013 17:48:51 +0800
Subject: [PATCHv2 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER
 board.
In-Reply-To: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1377856132-11290-4-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree for VF610 TOWER board, and there are 6 PWM
channels avaliable.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 1a58678..82b0a91 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -57,6 +57,12 @@
 	status = "okay";
 };
 
+&pwm0 {
+	fsl,pwm-counter-clk = "ftm0";
+	fsl,pwm-avaliable-chs = <0 1 2 3 6 7>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0
