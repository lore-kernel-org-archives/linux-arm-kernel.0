From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 20 Oct 2016 17:21:26 +0200
Subject: [PATCH 4/4] ARM: dts: stm32f429: remove Ethernet wake on Lan support
In-Reply-To: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
References: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1476976886-23781-5-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes WoL (Wake on Lan) support as it is not yet
fully supported and tested.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 6350117b..ad0bc6a 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -377,8 +377,8 @@
 			compatible = "st,stm32-dwmac", "snps,dwmac-3.50a";
 			reg = <0x40028000 0x8000>;
 			reg-names = "stmmaceth";
-			interrupts = <61>, <62>;
-			interrupt-names = "macirq", "eth_wake_irq";
+			interrupts = <61>;
+			interrupt-names = "macirq";
 			clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
 			clocks = <&rcc 0 25>, <&rcc 0 26>, <&rcc 0 27>;
 			st,syscon = <&syscfg 0x4>;
-- 
1.9.1
