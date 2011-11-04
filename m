From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 4 Nov 2011 17:34:23 +0800
Subject: [PATCH 1/1] ARM: mx51/53: correct clocks that take ipg_perclk as
	parent
Message-ID: <1320399263-14885-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpt_clk, pwm1_clk and pwm2_clk parent clock are all ipg_perclk.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 2aacf41..a3ca4ce 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1278,12 +1278,12 @@ DEFINE_CLOCK(uart5_clk, 4, MXC_CCM_CCGR7, MXC_CCM_CCGRx_CG7_OFFSET,
 DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
 DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
-	NULL,  NULL, &ipg_clk, &gpt_ipg_clk);
+	NULL,  NULL, &ipg_perclk, &gpt_ipg_clk);
 
 DEFINE_CLOCK(pwm1_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG6_OFFSET,
-	NULL, NULL, &ipg_clk, NULL);
+	NULL, NULL, &ipg_perclk, NULL);
 DEFINE_CLOCK(pwm2_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG8_OFFSET,
-	NULL, NULL, &ipg_clk, NULL);
+	NULL, NULL, &ipg_perclk, NULL);
 
 /* I2C */
 DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
-- 
1.7.5.4
