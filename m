From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 30 Apr 2018 09:11:20 +0200
Subject: [PATCH 1/2] ARM: dts: stm32: add qspi support for stm32mp157c
In-Reply-To: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
References: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1525072281-17472-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds qspi support on stm32mp157c,
read in memory mapped, write in indirect mode.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bfcf84b..7714949 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -5,6 +5,7 @@
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/stm32mp1-clks.h>
+#include <dt-bindings/reset/stm32mp1-resets.h>
 
 / {
 	#address-cells = <1>;
@@ -167,6 +168,16 @@
 			#reset-cells = <1>;
 		};
 
+		qspi: qspi at 58003000 {
+			compatible = "st,stm32f469-qspi";
+			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
+			reg-names = "qspi", "qspi_mm";
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc QSPI_K>;
+			resets = <&rcc QSPI_R>;
+			status = "disabled";
+		};
+
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
2.7.4
