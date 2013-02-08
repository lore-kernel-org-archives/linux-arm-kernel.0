From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  8 Feb 2013 13:36:42 -0200
Subject: [PATCH 2/3] ARM: dts: imx28-apx4devkit: Enable touchscreen support
In-Reply-To: <1360337803-19858-1-git-send-email-festevam@gmail.com>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
Message-ID: <1360337803-19858-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Provide 'lradc-touchscreen-wires' property to the LRADC driver, so that 
touchscreen can be functional.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 5171667..bb615d5 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -131,6 +131,11 @@
 				};
 			};
 
+			lradc at 80050000 {
+				fsl,lradc-touchscreen-wires = <4>;
+				status = "okay";
+			};
+
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
-- 
1.7.9.5
