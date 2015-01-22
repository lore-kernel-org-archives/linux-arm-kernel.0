From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 22 Jan 2015 17:13:15 +0100
Subject: [PATCH v12 5/6] clkdev: Export clk_register_clkdev
In-Reply-To: <1421943207-5180-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1421943207-5180-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1421943207-5180-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So it can be used from modules such as clk-test.ko.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clkdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index fac3244..667ce38 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -379,6 +379,7 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 
 	return 0;
 }
+EXPORT_SYMBOL(clk_register_clkdev);
 
 /**
  * clk_register_clkdevs - register a set of clk_lookup for a struct clk
-- 
1.9.3
