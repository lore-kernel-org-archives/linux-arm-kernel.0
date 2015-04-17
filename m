From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 17 Apr 2015 11:50:23 +0100
Subject: [PATCH 5/5] ARM: DT: STi: STiH407: Add DT node for st-lpc timer.
In-Reply-To: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
References: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1429267823-8879-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dt node for the st-lpc timer found on
stih407 famliy SoCs. This can then be used as a clocksource.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c06a546..59c6a22 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -39,6 +39,13 @@
 		reg = <0x08760000 0x1000>;
 	};
 
+	lpc-timer at 0x8788000 {
+		compatible = "st,st_lpc_timer";
+		reg = <0x8788000 0x1000>;
+		clock-names = "lpc_clk";
+		clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
+	};
+
 	timer at 08760200 {
 		interrupt-parent = <&intc>;
 		compatible = "arm,cortex-a9-global-timer";
-- 
1.9.1
