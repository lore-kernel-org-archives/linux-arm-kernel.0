From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 26 Jan 2015 11:13:58 +0000
Subject: [PATCH 2/4] ARM: sti: stih407-family: Provide Clock Domain information
In-Reply-To: <1422270840-3039-1-git-send-email-lee.jones@linaro.org>
References: <1422270840-3039-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1422270840-3039-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain clocks should not be turned of by clk_disable_unused.  Until
now we have been using the kernel command-line of the same name to
prevent common clk from turning off all clocks without a reference,
as this would ensure hardware lockup.  This patch lists each clock
which need to stay on to prevent the aforementioned issue from
arising.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 3e31d32..0478b41 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -34,6 +34,19 @@
 		reg = <0x08761000 0x1000>, <0x08760100 0x100>;
 	};
 
+	clk-domain {
+		compatible = "st,clk-domain";
+		clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+			 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+			 <&clk_s_c0_flexgen CLK_MMC_1>,
+			 <&clk_s_c0_flexgen CLK_ICN_SBC>,
+			 <&clk_s_c0_flexgen CLK_ICN_LMI>,
+			 <&clk_s_c0_flexgen CLK_ICN_CPU>,
+			 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+			 <&clk_s_a0_flexgen CLK_IC_LMI0>,
+			 <&clk_m_a9>;
+	};
+
 	scu at 08760000 {
 		compatible = "arm,cortex-a9-scu";
 		reg = <0x08760000 0x1000>;
-- 
1.9.1
