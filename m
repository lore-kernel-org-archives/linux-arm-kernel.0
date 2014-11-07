From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri,  7 Nov 2014 18:34:26 +0530
Subject: [[PATCHv2] 1/3] ARM: imx: clk-vf610: Add clock for SNVS
In-Reply-To: <cover.1415364391.git.maitysanchayan@gmail.com>
References: <cover.1415364391.git.maitysanchayan@gmail.com>
Message-ID: <bbe86ff8ff7461451be5c53242842e966bfd3966.1415364391.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for clock gating of
the SNVS peripheral.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/mach-imx/clk-vf610.c           |    1 +
 include/dt-bindings/clock/vf610-clock.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-vf610.c b/arch/arm/mach-imx/clk-vf610.c
index 5937dde..bbf4785 100644
--- a/arch/arm/mach-imx/clk-vf610.c
+++ b/arch/arm/mach-imx/clk-vf610.c
@@ -379,6 +379,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DMAMUX1] = imx_clk_gate2("dmamux1", "platform_bus", CCM_CCGR0, CCM_CCGRx_CGn(5));
 	clk[VF610_CLK_DMAMUX2] = imx_clk_gate2("dmamux2", "platform_bus", CCM_CCGR6, CCM_CCGRx_CGn(1));
 	clk[VF610_CLK_DMAMUX3] = imx_clk_gate2("dmamux3", "platform_bus", CCM_CCGR6, CCM_CCGRx_CGn(2));
+	clk[VF610_CLK_SNVS] = imx_clk_gate2("snvs-rtc", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(7));
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 801c0ac..979d24a 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -192,6 +192,7 @@
 #define VF610_PLL5_BYPASS		179
 #define VF610_PLL6_BYPASS		180
 #define VF610_PLL7_BYPASS		181
-#define VF610_CLK_END			182
+#define VF610_CLK_SNVS			182
+#define VF610_CLK_END			183
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
1.7.9.5
