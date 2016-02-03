From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed,  3 Feb 2016 12:04:44 +0100
Subject: [PATCH v5 8/9] ARM: dts: Add leds support to STM32F429 boards
In-Reply-To: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1454497485-464-9-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts  | 17 +++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 71fe17a..e3921d9 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -64,6 +64,23 @@
 	aliases {
 		serial0 = &usart1;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		green {
+			gpios = <&gpiog 6 1>;
+			linux,default-trigger = "heartbeat";
+		};
+		orange {
+			gpios = <&gpiog 7 1>;
+		};
+		red {
+			gpios = <&gpiog 10 1>;
+		};
+		blue {
+			gpios = <&gpiog 12 1>;
+		};
+	};
 };
 
 &clk_hse {
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index e3ce796..0140807 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -64,6 +64,17 @@
 	aliases {
 		serial0 = &usart1;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		red {
+			gpios = <&gpiog 14 0>;
+		};
+		green {
+			gpios = <&gpiog 13 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
 
 &clk_hse {
-- 
1.9.1
