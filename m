From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 14 Nov 2018 10:00:26 +0100
Subject: [PATCH v4 3/4] ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
In-Reply-To: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
Message-ID: <20181114090027.7580-4-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Declare hwspinlock device for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 185541a5b69f..98f824d8b0f0 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -803,6 +803,15 @@
 			status = "disabled";
 		};
 
+		hsem: hwspinlock at 4c000000 {
+			compatible = "st,stm32-hwspinlock";
+			#hwlock-cells = <1>;
+			reg = <0x4c000000 0x400>;
+			clocks = <&rcc HSEM>;
+			clock-names = "hwsem";
+			status = "disabled";
+		};
+
 		rcc: rcc at 50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.15.0
