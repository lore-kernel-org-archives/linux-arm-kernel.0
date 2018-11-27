From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 27 Nov 2018 17:48:17 +0100
Subject: [PATCH 3/3] ARM: dts: stm32: Add clock on stm32mp157c syscfg
In-Reply-To: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
References: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1543337297-21873-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 syscfg needs a clock to access registers.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 8bf1c17..61b2a70 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -820,6 +820,7 @@
 		syscfg: syscon at 50020000 {
 			compatible = "st,stm32mp157-syscfg", "syscon";
 			reg = <0x50020000 0x400>;
+			clocks = <&rcc SYSCFG>;
 		};
 
 		lptimer2: timer at 50021000 {
-- 
1.9.1
