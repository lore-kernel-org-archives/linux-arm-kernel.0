From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed,  7 Sep 2016 09:58:58 +0200
Subject: [PATCH v4 5/8] dts: sun8i-h3: add pinmux definitions for UART2-3
In-Reply-To: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473235141-12768-6-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

These are the pinmux definitions for uarts2-3 on H3. These are the only
pins for these UARTS, but one could choose to use reduce them to only
RX/TX.

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 685755c..5cde54c 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -373,6 +373,20 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			uart2_rts_cts_pins: uart2_rts_cts {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_rts_cts_pins: uart3_rts_cts {
+				allwinner,pins = "PA13", "PA14", "PA15", "PA16";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.7.4
