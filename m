From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 7 Jun 2017 09:16:21 +0200
Subject: [PATCH 1/3] ARM: dts: stm32: Add usart2_pins on stm32h743
In-Reply-To: <1496819783-5113-1-git-send-email-patrice.chotard@st.com>
References: <1496819783-5113-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1496819783-5113-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Add usart2 pins definition in order to add usart2 support
dedicated for console output on stm32h743i-disco board.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index fcc1e06..76bbd65 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -151,6 +151,19 @@
 					bias-disable;
 				};
 			};
+
+			usart2_pins: usart2 at 0 {
+				pins1 {
+					pinmux = <STM32H7_PD5_FUNC_USART2_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32H7_PD6_FUNC_USART2_RX>;
+					bias-disable;
+				};
+			};
 		};
 	};
 };
-- 
1.9.1
