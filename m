From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:23 +0200
Subject: [PATCH v2 8/9] ARM: dts: Add leds support to STM32F429 Discovery board
In-Reply-To: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102604-11502-9-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index e3ce796..532c499 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -64,6 +64,16 @@
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
+		};
+	};
 };
 
 &clk_hse {
-- 
1.9.1
