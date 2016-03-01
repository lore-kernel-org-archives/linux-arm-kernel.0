From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Tue,  1 Mar 2016 12:42:49 -0500
Subject: [PATCH 3/3] ARM: dts: NSP: Add PWM Support to DT
In-Reply-To: <1456854169-9788-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1456854169-9788-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1456854169-9788-4-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM support to the device tree for the Broadcom Northstar Plus SoC.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index def9e78..f9c8341 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -206,6 +206,14 @@
 			brcm,nand-has-wp;
 		};
 
+		pwm: pwm at 31000 {
+			compatible = "brcm,iproc-pwm";
+			reg = <0x31000 0x28>;
+			clocks = <&osc>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		ccbtimer0: timer at 34000 {
 			compatible = "arm,sp804";
 			reg = <0x34000 0x1000>;
-- 
2.1.0
