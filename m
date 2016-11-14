From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Mon, 14 Nov 2016 08:30:19 -0500
Subject: [PATCH 1/1] ARM: dts: enable GPIO-b for Broadcom NSP
Message-ID: <1479130219-25639-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the GPIO-b support for Broadcom NSP SoC

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 7c9e0fa..2f699a0 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -241,6 +241,16 @@
 			brcm,nand-has-wp;
 		};
 
+		gpiob: gpio at 30000 {
+			compatible = "brcm,iproc-nsp-gpio", "brcm,iproc-gpio";
+			reg = <0x30000 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			ngpios = <4>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pwm: pwm at 31000 {
 			compatible = "brcm,iproc-pwm";
 			reg = <0x31000 0x28>;
-- 
2.1.0
