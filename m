From: vikas.manocha@st.com (Vikas Manocha)
Date: Thu, 28 Sep 2017 15:51:26 -0700
Subject: [PATCH 3/3] ARM: dts: stm32h7: correct uart nodes compatible string
In-Reply-To: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
References: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
Message-ID: <1506639114-16913-4-git-send-email-vikas.manocha@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this change, stm32h743 will use its own uart configuration.
Major difference between stm32f7 & stm32h7 uart configuration is FIFO
availability in stm32h7.

Signed-off-by: Vikas Manocha <vikas.manocha@st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 26de315..fab637b 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -67,7 +67,7 @@
 		};
 
 		usart2: serial at 40004400 {
-			compatible = "st,stm32f7-uart";
+			compatible = "st,stm32h7-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
 			status = "disabled";
@@ -99,7 +99,7 @@
 		};
 
 		usart1: serial at 40011000 {
-			compatible = "st,stm32f7-uart";
+			compatible = "st,stm32h7-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
 			status = "disabled";
-- 
1.9.1
