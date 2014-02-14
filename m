From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 14 Feb 2014 17:15:01 -0300
Subject: [PATCH 2/4] clk: mvebu: add a little bit of documentation about data
 structures
In-Reply-To: <1392408903-31237-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392408903-31237-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392408903-31237-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392408903-31237-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clk/mvebu/clk-corediv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index fb79375..59db71d 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -22,12 +22,24 @@
 #define CORE_CLK_DIV_ENABLE_OFFSET	24
 #define CORE_CLK_DIV_RATIO_OFFSET	0x8
 
+/*
+ * This structure describes the hardware details (bit offset and mask)
+ * to configure one particular core divider clock. Those hardware
+ * details may differ from one SoC to another. This structure is
+ * therefore typically instantiated statically to describe the
+ * hardware details.
+ */
 struct clk_corediv_desc {
 	unsigned int mask;
 	unsigned int offset;
 	unsigned int fieldbit;
 };
 
+/*
+ * This structure represents one core divider clock for the clock
+ * framework, and is dynamically allocated for each core divider clock
+ * existing in the current SoC.
+ */
 struct clk_corediv {
 	struct clk_hw hw;
 	void __iomem *reg;
@@ -37,6 +49,11 @@ struct clk_corediv {
 
 static struct clk_onecell_data clk_data;
 
+/*
+ * Description of the core divider clocks available. For now, we
+ * support only NAND, and it is available at the same register
+ * locations regardless of the SoC.
+ */
 static const struct clk_corediv_desc mvebu_corediv_desc[] = {
 	{ .mask = 0x3f, .offset = 8, .fieldbit = 1 }, /* NAND clock */
 };
-- 
1.8.1.5
