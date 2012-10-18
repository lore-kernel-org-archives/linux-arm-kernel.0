From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 18 Oct 2012 19:18:32 +0200
Subject: [PATCH 1/8] clk/ux500: explicitly include register header
Message-ID: <1350580712-8338-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The ux500 clock driver file named u8500_clk.c does not compile
if it loose implicit dependencies to <mach/db8500-regs.h>
(I have no clue what files will include this) which manifests
itself as I'm experimenting with SPARSE_IRQ so make the
dependency explicit.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mike, if you don't take this in as a fix to the v3.7-rc:s
I request an ACK so I can merge this series together.
---
 drivers/clk/ux500/u8500_clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index ca4a25e..ab30ce8 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -12,7 +12,7 @@
 #include <linux/clk-provider.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/platform_data/clk-ux500.h>
-
+#include <mach/db8500-regs.h>
 #include "clk.h"
 
 void u8500_clk_init(void)
-- 
1.7.11.3
