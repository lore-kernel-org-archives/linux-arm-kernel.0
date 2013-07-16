From: otavio@ossystems.com.br (Otavio Salvador)
Date: Tue, 16 Jul 2013 09:56:13 -0300
Subject: [PATCH v2 2/4] ARM: dts: imx23-evk: enable Low Resolution ADC
In-Reply-To: <1373979376-31583-1-git-send-email-otavio@ossystems.com.br>
References: <1373979376-31583-1-git-send-email-otavio@ossystems.com.br>
Message-ID: <1373979376-31583-2-git-send-email-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.XM23 has a internal Low Resolution ADC; this enables the support
for this device.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
Changes in v2: None

 arch/arm/boot/dts/imx23-evk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index dc3ab45..185c7c0 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -90,6 +90,11 @@
 		};
 
 		apbx at 80040000 {
+			lradc at 80050000 {
+				status = "okay";
+				fsl,lradc-touchscreen-wires = <4>;
+			};
+
 			pwm: pwm at 80064000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pwm2_pins_a>;
-- 
1.8.3.2
