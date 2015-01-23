From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 23 Jan 2015 12:03:32 +0100
Subject: [PATCH v13 5/6] clkdev: Export clk_register_clkdev
In-Reply-To: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1422011024-32283-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So it can be used from modules such as clk-test.ko.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clkdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 901d242..29a1ab7 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -377,6 +377,7 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 
 	return 0;
 }
+EXPORT_SYMBOL(clk_register_clkdev);
 
 /**
  * clk_register_clkdevs - register a set of clk_lookup for a struct clk
-- 
1.9.3
