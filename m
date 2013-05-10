From: marex@denx.de (Marek Vasut)
Date: Fri, 10 May 2013 14:26:35 +0200
Subject: [PATCH 2/2] ARM: mxs: Fix UARTs on M28EVK
In-Reply-To: <1368188795-9114-1-git-send-email-marex@denx.de>
References: <1368188795-9114-1-git-send-email-marex@denx.de>
Message-ID: <1368188795-9114-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of RTS/CTS lines on AUART0 and register AUART1 and AUART2
which are routed onto a pin header.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-m28evk.dts |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index fd36e1c..ed1f1c0 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -195,7 +195,19 @@
 
 			auart0: serial at 8006a000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&auart0_2pins_a>;
+				pinctrl-0 = <&auart0_pins_a>;
+				status = "okay";
+			};
+
+			auart1: serial at 8006c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart1_pins_a>;
+				status = "okay";
+			};
+
+			auart2: serial at 8006e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart2_2pins_b>;
 				status = "okay";
 			};
 		};
-- 
1.7.10.4
