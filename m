From: leo.yan@linaro.org (Leo Yan)
Date: Fri,  1 Sep 2017 08:47:14 +0800
Subject: [PATCH 1/2] clk: hi6220: mark clock cs_atb_syspll as critical
In-Reply-To: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
References: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1504226835-2115-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock cs_atb_syspll is pll used for coresight trace bus; when clock
cs_atb_syspll is disabled and operates its child clock node cs_atb
results in system hang. So mark clock cs_atb_syspll as critical to
keep it enabled.

Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk-hi6220.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index 4181b68..4742e8f 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -145,7 +145,7 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
 	{ HI6220_BBPPLL_SEL,    "bbppll_sel",    "pll0_bbp_gate",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 9,  0, },
 	{ HI6220_MEDIA_PLL_SRC, "media_pll_src", "pll_media_gate", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 10, 0, },
 	{ HI6220_MMC2_SEL,      "mmc2_sel",      "mmc2_mux1",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 11, 0, },
-	{ HI6220_CS_ATB_SYSPLL, "cs_atb_syspll", "syspll",         CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 12, 0, },
+	{ HI6220_CS_ATB_SYSPLL, "cs_atb_syspll", "syspll",         CLK_SET_RATE_PARENT|CLK_IS_CRITICAL,   0x270, 12, 0, },
 };
 
 static struct hisi_mux_clock hi6220_mux_clks_sys[] __initdata = {
-- 
2.7.4
