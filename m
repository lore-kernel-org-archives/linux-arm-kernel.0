From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 15:23:20 +0800
Subject: [PATCH 01/10] clk: use kzalloc in clk_register_mux
In-Reply-To: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1332833009-4121-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change clk_register_mux to use kzalloc, just like what all other basic
clk registration functions do.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk-mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index c71ad1f..50e0595 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -97,7 +97,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 {
 	struct clk_mux *mux;
 
-	mux = kmalloc(sizeof(struct clk_mux), GFP_KERNEL);
+	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
 
 	if (!mux) {
 		pr_err("%s: could not allocate mux clk\n", __func__);
-- 
1.7.5.4
