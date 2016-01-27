From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Jan 2016 17:11:04 +0100
Subject: [PATCH v4 05/13] clk: at91: pmc: move pmc structures to C file
In-Reply-To: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1453911072-23608-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pmc.c is now the only user of struct at91_pmc*, move their definition in
the C file.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/at91/pmc.c | 9 +++++++++
 drivers/clk/at91/pmc.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 01d049d4248a..0b255e7fc718 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -20,6 +20,15 @@
 
 #include "pmc.h"
 
+struct at91_pmc_caps {
+	u32 available_irqs;
+};
+
+struct at91_pmc {
+	struct regmap *regmap;
+	const struct at91_pmc_caps *caps;
+};
+
 void __iomem *at91_pmc_base;
 EXPORT_SYMBOL_GPL(at91_pmc_base);
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index b06a332b056a..5771fff0ee3f 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -26,15 +26,6 @@ struct clk_range {
 
 #define CLK_RANGE(MIN, MAX) {.min = MIN, .max = MAX,}
 
-struct at91_pmc_caps {
-	u32 available_irqs;
-};
-
-struct at91_pmc {
-	struct regmap *regmap;
-	const struct at91_pmc_caps *caps;
-};
-
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range);
 
-- 
2.5.0
