From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 29 Sep 2014 13:17:48 +0530
Subject: [PATCH v2 3/3] clk: samsung: remove unnecessary inclusion of header
 files from clk.h
In-Reply-To: <1411976868-22209-1-git-send-email-pankaj.dubey@samsung.com>
References: <1411976868-22209-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1411976868-22209-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's remove unnecessary include of header files from clk.h and add
required one in clk.c

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/samsung/clk.c |    3 ++-
 drivers/clk/samsung/clk.h |    4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 31bf391..952f9ec 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -11,7 +11,8 @@
  * clock framework for Samsung platforms.
 */
 
-#include <linux/syscore_ops.h>
+#include <linux/of_address.h>
+
 #include "clk.h"
 
 void samsung_clk_save(void __iomem *base,
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index a1ece4a..29a5779 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -13,12 +13,8 @@
 #ifndef __SAMSUNG_CLK_H
 #define __SAMSUNG_CLK_H
 
-#include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/io.h>
 #include <linux/clk-provider.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include "clk-pll.h"
 
 /**
-- 
1.7.9.5
