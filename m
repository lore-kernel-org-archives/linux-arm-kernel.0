From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 22 Sep 2014 16:12:03 +0200
Subject: [PATCH v12 01/10] clk: Export __clk_put and __clk_get so they can be
 used by modules
In-Reply-To: <1411395124-2476-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1411395124-2476-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1411395124-2476-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for the split between provider and user clk APIs, for clocks
that are implemented in modules.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b76fa69..5db9710 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2197,6 +2197,7 @@ int __clk_get(struct clk *clk)
 	}
 	return 1;
 }
+EXPORT_SYMBOL(__clk_get);
 
 void __clk_put(struct clk *clk)
 {
@@ -2209,6 +2210,7 @@ void __clk_put(struct clk *clk)
 
 	module_put(clk->owner);
 }
+EXPORT_SYMBOL(__clk_put);
 
 /***        clk rate change notifiers        ***/
 
-- 
1.9.3
