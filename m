From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 25 Sep 2017 13:46:41 +0530
Subject: [PATCH 3/3] clocksource: rockchip: pr_err() strings should end with
 newlines
In-Reply-To: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1506327401-30521-4-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should terminated with a new-line to avoid
other messages being concatenated onto the end.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clocksource/rockchip_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index c27f4c8..33f370d 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -274,7 +274,7 @@ static int __init rk_clksrc_init(struct device_node *np)
 		TIMER_NAME, rk_clksrc->freq, 250, 32,
 		clocksource_mmio_readl_down);
 	if (ret) {
-		pr_err("Failed to register clocksource");
+		pr_err("Failed to register clocksource\n");
 		goto out_clocksource;
 	}
 
-- 
1.9.1
