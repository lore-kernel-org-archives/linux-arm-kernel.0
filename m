From: otavio@ossystems.com.br (Otavio Salvador)
Date: Tue, 16 Jul 2013 09:56:14 -0300
Subject: [PATCH v2 3/4] ARM: dts: imx23-olinuxino: enable Low Resolution ADC
In-Reply-To: <1373979376-31583-1-git-send-email-otavio@ossystems.com.br>
References: <1373979376-31583-1-git-send-email-otavio@ossystems.com.br>
Message-ID: <1373979376-31583-3-git-send-email-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.XM23 has a internal Low Resolution ADC; this enables the support
for this device.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
Changes in v2: None

 arch/arm/boot/dts/imx23-olinuxino.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index d107c4a..fc766ae 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -69,6 +69,10 @@
 		};
 
 		apbx at 80040000 {
+			lradc at 80050000 {
+				status = "okay";
+			};
+
 			duart: serial at 80070000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
-- 
1.8.3.2
