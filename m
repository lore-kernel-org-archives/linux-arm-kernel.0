From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri, 15 Jul 2016 04:28:26 -0400
Subject: [PATCH 1/1] arm64: dts: Add PWM DT node for NS2
Message-ID: <1468571306-20976-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree entry for PWM support for Broadcom Northstar 2 SoC.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index ec68ec1..9c2857c 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -263,6 +263,14 @@
 				      IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		pwm: pwm at 66010000 {
+			compatible = "brcm,iproc-pwm";
+			reg = <0x66010000 0x28>;
+			clocks = <&osc>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		timer0: timer at 66030000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x66030000 0x1000>;
-- 
2.1.0
