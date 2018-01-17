From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 17 Jan 2018 10:40:03 +0100
Subject: [PATCH] ARM: dts: stm32: Add leds support to stm32f769 Discovery board
In-Reply-To: <20180117094005.20728-1-benjamin.gaignard@st.com>
References: <20180117094005.20728-1-benjamin.gaignard@st.com>
Message-ID: <20180117094005.20728-2-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the two user leds.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f769-disco.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index 4463ca13a740..25a4b71f0317 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -61,6 +61,16 @@
 		serial0 = &usart1;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		green {
+			gpios = <&gpioj 5 0>;
+			linux,default-trigger = "heartbeat";
+		};
+		red {
+			gpios = <&gpioj 13 0>;
+		};
+	};
 };
 
 &cec {
-- 
2.15.0
