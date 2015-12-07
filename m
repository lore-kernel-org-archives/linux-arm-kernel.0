From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:18 +0000
Subject: [PATCH 05/19] mfd: ab8500-debugfs: Clean-up non-conforming commenting
 and print formatting
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Block comments use a trailing */ on a separate line
+                        * not be accessed from here */

WARNING: Block comments use a trailing */ on a separate line
+                        * not be accessed from here */

WARNING: Block comments use a trailing */ on a separate line
+                                * the output is wanted in any case */

WARNING: Consecutive strings are generally better as a single string
+               "  addr=0x%08X, mask=0x%X, shift=%d" "value=0x%X\n",

total: 0 errors, 4 warnings, 3331 lines checked

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 0236cd7..69d9fff 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -242,8 +242,10 @@ static struct ab8500_prcmu_ranges ab8500_debug_ranges[AB8500_NUM_BANKS] = {
 				.first = 0x40,
 				.last = 0x44,
 			},
-			/* 0x80-0x8B is SIM registers and should
-			 * not be accessed from here */
+			/*
+			 * 0x80-0x8B are SIM registers and should
+			 * not be accessed from here
+			 */
 		},
 	},
 	[AB8500_USB] = {
@@ -587,8 +589,10 @@ static struct ab8500_prcmu_ranges ab8505_debug_ranges[AB8500_NUM_BANKS] = {
 				.first = 0x40,
 				.last = 0x48,
 			},
-			/* 0x80-0x8B is SIM registers and should
-			 * not be accessed from here */
+			/*
+			 * 0x80-0x8B are SIM registers and should
+			 * not be accessed from here
+			 */
 		},
 	},
 	[AB8500_USB] = {
@@ -1306,8 +1310,10 @@ static int ab8500_registers_print(struct device *dev, u32 bank,
 			if (s) {
 				seq_printf(s, "  [0x%02X/0x%02X]: 0x%02X\n",
 					   bank, reg, value);
-				/* Error is not returned here since
-				 * the output is wanted in any case */
+				/*
+				 * Error is not returned here since
+				 * the output is wanted in any case
+				 */
 				if (seq_has_overflowed(s))
 					return 0;
 			} else {
@@ -2740,10 +2746,9 @@ static ssize_t hwreg_common_write(char *b, struct hwreg_cfg *cfg,
 	*cfg = loc;
 
 #ifdef ABB_HWREG_DEBUG
-	pr_warn("HWREG request: %s, %s,\n"
-		"  addr=0x%08X, mask=0x%X, shift=%d" "value=0x%X\n",
-		(write) ? "write" : "read",
-		REG_FMT_DEC(cfg) ? "decimal" : "hexa",
+	pr_warn("HWREG request: %s, %s,\n", (write) ? "write" : "read",
+		REG_FMT_DEC(cfg) ? "decimal" : "hexa");
+	pr_warn("  addr=0x%08X, mask=0x%X, shift=%d" "value=0x%X\n",
 		cfg->addr, cfg->mask, cfg->shift, val);
 #endif
 
-- 
1.9.1
