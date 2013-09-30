From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 30 Sep 2013 14:13:30 +0800
Subject: [PATCHv5 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER
 board.
In-Reply-To: <1380521611-2764-1-git-send-email-Li.Xiubo@freescale.com>
References: <1380521611-2764-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1380521611-2764-4-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting system clock as the counter source clock by default.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 1a58678..4257054 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -57,6 +57,13 @@
 	status = "okay";
 };
 
+&pwm0 {
+	fsl,pwm-counter-clk = "ftm0";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0
