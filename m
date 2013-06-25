From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:46 +0200
Subject: [PATCH 02/16] ARM: dts: i.MX6qdl: Add compatible and clock to flexcan
 nodes
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f21d259..9efaa56 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -278,13 +278,19 @@
 			};
 
 			can1: flexcan at 02090000 {
+				compatible = "fsl,imx6q-flexcan";
 				reg = <0x02090000 0x4000>;
 				interrupts = <0 110 0x04>;
+				clocks = <&clks 108>, <&clks 109>;
+				clock-names = "ipg", "per";
 			};
 
 			can2: flexcan at 02094000 {
+				compatible = "fsl,imx6q-flexcan";
 				reg = <0x02094000 0x4000>;
 				interrupts = <0 111 0x04>;
+				clocks = <&clks 110>, <&clks 111>;
+				clock-names = "ipg", "per";
 			};
 
 			gpt: gpt at 02098000 {
-- 
1.8.3.1
