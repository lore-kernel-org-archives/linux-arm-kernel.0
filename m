From: otavio@ossystems.com.br (Otavio Salvador)
Date: Mon, 15 Jul 2013 11:22:39 -0300
Subject: [PATCH 4/5] ARM: dts: imx23-olinuxino: enable Low Resolution ADC
In-Reply-To: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
References: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
Message-ID: <1373898160-8460-4-git-send-email-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.XM23 has a internal Low Resolution ADC; this enables the support
for this device.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
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
