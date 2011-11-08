From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 8 Nov 2011 09:59:34 +0800
Subject: [PATCH V2 1/1] ARM: mx51/53: set pwm clock parent to ipg_perclk
Message-ID: <1320717574-12633-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
Changes from V1:
 - remove parent changes of gpt_clk

 arch/arm/mach-mx5/clock-mx51-mx53.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 2aacf41..63cb759 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1281,9 +1281,9 @@ DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
 	NULL,  NULL, &ipg_clk, &gpt_ipg_clk);
 
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
