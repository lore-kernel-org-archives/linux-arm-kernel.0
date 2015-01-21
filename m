From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Jan 2015 15:24:28 +0000
Subject: [PATCH v4 10/10] ARM: STi: stih416: Supply EMI clock reference to FSM
 SPI NOR
In-Reply-To: <1421853868-8262-1-git-send-email-lee.jones@linaro.org>
References: <1421853868-8262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1421853868-8262-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we're at it we're also adding a new human readable define for the
aforementioned clock.

Cc: devicetree at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi           | 2 +-
 include/dt-bindings/clock/stih416-clks.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 2e35bab7..39b856b 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -219,7 +219,7 @@
 			compatible	   = "st,stih416-spi-fsm";
 			reg		   = <0xfe902000 0x1000>;
 			pinctrl-0	   = <&pinctrl_fsm>;
-
+			clocks		   = <&clk_s_a0_ls CLK_EMISS>;
 			st,syscfg	   = <&syscfg_rear>;
 
 			status = "disabled";
diff --git a/include/dt-bindings/clock/stih416-clks.h b/include/dt-bindings/clock/stih416-clks.h
index f9bdbd1..4a46a47e 100644
--- a/include/dt-bindings/clock/stih416-clks.h
+++ b/include/dt-bindings/clock/stih416-clks.h
@@ -7,6 +7,7 @@
 
 /* CLOCKGEN A0 */
 #define CLK_ICN_REG		0
+#define CLK_EMISS		3
 #define CLK_ETH1_PHY		4
 
 /* CLOCKGEN A1 */
-- 
1.9.1
