From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 22 Oct 2012 15:58:00 +0200
Subject: [PATCH 4/5] clk: ux500: Update rtc clock lookup for u8500
In-Reply-To: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1350914281-1332-5-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index be843ba..0aae929 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -40,7 +40,7 @@ void u8500_clk_init(void)
 				CLK_IS_ROOT|CLK_IGNORE_UNUSED,
 				32768);
 	clk_register_clkdev(clk, "clk32k", NULL);
-	clk_register_clkdev(clk, NULL, "rtc-pl031");
+	clk_register_clkdev(clk, "apb_pclk", "rtc-pl031");
 
 	/* PRCMU clocks */
 	fw_version = prcmu_get_fw_version();
-- 
1.7.10
