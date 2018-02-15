From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 15 Feb 2018 09:20:13 +0100
Subject: [PATCH 2/3] ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi
In-Reply-To: <20180215082014.30383-1-philippe.cornu@st.com>
References: <20180215082014.30383-1-philippe.cornu@st.com>
Message-ID: <20180215082014.30383-3-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the stm32f4 family, mipi dsi is only supported on stm32f469.
So add a new stm32f469 dtsi file & add mipi dsi support inside.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 arch/arm/boot/dts/stm32f469.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32f469.dtsi

diff --git a/arch/arm/boot/dts/stm32f469.dtsi b/arch/arm/boot/dts/stm32f469.dtsi
new file mode 100644
index 000000000000..5ae5213f68cb
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f469.dtsi
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright (C) STMicroelectronics 2017 - All Rights Reserved */
+
+#include "stm32f429.dtsi"
+
+/ {
+	soc {
+		dsi: dsi at 40016c00 {
+			compatible = "st,stm32-dsi";
+			reg = <0x40016c00 0x800>;
+			interrupts = <92>;
+			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
+			reset-names = "apb";
+			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
+			clock-names = "pclk", "ref";
+			status = "disabled";
+		};
+	};
+};
-- 
2.15.1
