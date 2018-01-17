From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 17 Jan 2018 10:40:04 +0100
Subject: [PATCH] ARM: dts: stm32: Add push button to stm32f469 Discovery board
In-Reply-To: <20180117094005.20728-1-benjamin.gaignard@st.com>
References: <20180117094005.20728-1-benjamin.gaignard@st.com>
Message-ID: <20180117094005.20728-3-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for user push button.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 5e9994840a24..c93d83d53bc8 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -86,6 +86,18 @@
 			gpios = <&gpiok 3 1>;
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+		button at 0 {
+			label = "User";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpioa 0 0>;
+		};
+	};
+
 	/* This turns on vbus for otg for host mode (dwc2) */
 	vcc5v_otg: vcc5v-otg-regulator {
 		compatible = "regulator-fixed";
-- 
2.15.0
