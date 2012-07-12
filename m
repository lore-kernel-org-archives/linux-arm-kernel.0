From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 12 Jul 2012 19:39:29 +0400
Subject: [PATCH v2 2/4] ARM: i.MX5x clocks: Fix parent for PWM clocks
In-Reply-To: <1342107571-15454-1-git-send-email-shc_work@mail.ru>
References: <1342107571-15454-1-git-send-email-shc_work@mail.ru>
Message-ID: <1342107571-15454-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index d4653d9..3481e18 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -170,9 +170,9 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[i2c2_gate] = imx_clk_gate2("i2c2_gate", "per_root", MXC_CCM_CCGR1, 20);
 	clk[gpt_ipg_gate] = imx_clk_gate2("gpt_ipg_gate", "ipg", MXC_CCM_CCGR2, 20);
 	clk[pwm1_ipg_gate] = imx_clk_gate2("pwm1_ipg_gate", "ipg", MXC_CCM_CCGR2, 10);
-	clk[pwm1_hf_gate] = imx_clk_gate2("pwm1_hf_gate", "ipg", MXC_CCM_CCGR2, 12);
+	clk[pwm1_hf_gate] = imx_clk_gate2("pwm1_hf_gate", "per_root", MXC_CCM_CCGR2, 12);
 	clk[pwm2_ipg_gate] = imx_clk_gate2("pwm2_ipg_gate", "ipg", MXC_CCM_CCGR2, 14);
-	clk[pwm2_hf_gate] = imx_clk_gate2("pwm2_hf_gate", "ipg", MXC_CCM_CCGR2, 16);
+	clk[pwm2_hf_gate] = imx_clk_gate2("pwm2_hf_gate", "per_root", MXC_CCM_CCGR2, 16);
 	clk[gpt_gate] = imx_clk_gate2("gpt_gate", "per_root", MXC_CCM_CCGR2, 18);
 	clk[fec_gate] = imx_clk_gate2("fec_gate", "ipg", MXC_CCM_CCGR2, 24);
 	clk[usboh3_gate] = imx_clk_gate2("usboh3_gate", "ipg", MXC_CCM_CCGR2, 26);
-- 
1.7.3.4
