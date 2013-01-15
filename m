From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:54 +0000
Subject: [PATCH 14/26] mfd: ab8500-debugfs: Fix introduced compiler time
 warnings
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@stericsson.com>

Some simple fixes regarding pre-processor usage.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 78a8e0c..7698d30 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -776,9 +776,9 @@ static ssize_t hwreg_common_write(char *b, struct hwreg_cfg *cfg,
 	/* args are ok, update target cfg (mainly for read) */
 	*cfg = loc;
 
-#if ABB_HWREG_DEBUG
-	pr_warn("HWREG request: %s, %s, addr=0x%08X, mask=0x%X, shift=%d
-			value=0x%X\n", (write) ? "write" : "read",
+#ifdef ABB_HWREG_DEBUG
+	pr_warn("HWREG request: %s, %s, addr=0x%08X, mask=0x%X, shift=%d"
+			"value=0x%X\n", (write) ? "write" : "read",
 			REG_FMT_DEC(cfg) ? "decimal" : "hexa",
 			cfg->addr, cfg->mask, cfg->shift, val);
 #endif
-- 
1.7.9.5
