From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Mon, 12 Sep 2016 20:12:43 +0200
Subject: [PATCH v5 1/5] dts: sun8i-h3: add pinmux definitions for UART2-3
In-Reply-To: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
References: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473703967-21356-2-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

These are the pinmux definitions for UART2-3 on H3. These UARTs can only
be muxed to these pins, so _a and @0 do not really make sense. I have
left out RTS/CTS, since these are rarely used. These can easily be
enabled using an additional pinmux set.

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fdf9fdb..665fa32 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -373,6 +373,20 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			uart2_pins: uart2 {
+				allwinner,pins = "PA0", "PA1";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_pins: uart3 {
+				allwinner,pins = "PG13", "PG14";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.7.4
