From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 6 Jun 2017 18:13:32 +0200
Subject: [PATCH 2/3] ARM: dts: stm32h743: Add usart2 support
In-Reply-To: <1496765613-697-1-git-send-email-patrice.chotard@st.com>
References: <1496765613-697-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1496765613-697-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This usart is used for console output on stm32h743i-disco board

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 4685629..36a99db 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -68,6 +68,14 @@
 
 		};
 
+		usart2: serial at 40004400 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40004400 0x400>;
+			interrupts = <38>;
+			status = "disabled";
+			clocks = <&timer_clk>;
+		};
+
 		timer5: timer at 40000c00 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000c00 0x400>;
-- 
1.9.1
