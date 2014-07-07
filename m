From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  7 Jul 2014 17:19:15 +0200
Subject: [PATCH 5/5] clk: at91: remove the useless CLK_IGNORE_UNUSED flag
In-Reply-To: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404746355-19988-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLK_IGNORE_UNUSED flag was added on all the system clocks because of the
ddrck. Now that it is handled by the ram controller driver, we can drop it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-system.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 8c96307d7363..a76d03fd577b 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -119,13 +119,7 @@ at91_clk_register_system(struct at91_pmc *pmc, const char *name,
 	init.ops = &system_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-	/*
-	 * CLK_IGNORE_UNUSED is used to avoid ddrck switch off.
-	 * TODO : we should implement a driver supporting at91 ddr controller
-	 * (see drivers/memory) which would request and enable the ddrck clock.
-	 * When this is done we will be able to remove CLK_IGNORE_UNUSED flag.
-	 */
-	init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
+	init.flags = CLK_SET_RATE_PARENT;
 
 	sys->id = id;
 	sys->hw.init = &init;
-- 
1.9.1
