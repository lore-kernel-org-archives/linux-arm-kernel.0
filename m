From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 22:14:39 +0100
Subject: [PATCH 18/28] thermal: drop owner assignment from platform_drivers
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1419196495-9626-19-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 drivers/thermal/rockchip_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 1bcddfc60e91..9c6ce548e363 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -677,7 +677,6 @@ static SIMPLE_DEV_PM_OPS(rockchip_thermal_pm_ops,
 static struct platform_driver rockchip_thermal_driver = {
 	.driver = {
 		.name = "rockchip-thermal",
-		.owner = THIS_MODULE,
 		.pm = &rockchip_thermal_pm_ops,
 		.of_match_table = of_rockchip_thermal_match,
 	},
-- 
2.1.3
