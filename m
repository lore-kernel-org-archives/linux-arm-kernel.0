From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 15 Apr 2013 08:59:46 +0200
Subject: [PATCH RESEND] clk: export __clk_get_flags for modular clock providers
Message-ID: <1366009186-32199-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clock api provides some helpers for clk-providers but does
not export these helpers. This hinders clk-providers to be built as modules.
This patch adds __clk_get_flags() to the list of exported symbols.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/clk.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed87b24..3e478b8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -450,6 +450,7 @@ unsigned long __clk_get_flags(struct clk *clk)
 {
 	return !clk ? 0 : clk->flags;
 }
+EXPORT_SYMBOL_GPL(__clk_get_flags);
 
 bool __clk_is_enabled(struct clk *clk)
 {
-- 
1.7.10.4
