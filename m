From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 Jan 2014 01:39:33 +0100
Subject: [PATCH v2 21/21] pinctrl: mvebu: dove: consolidate auto-numbered pmu
 mpp ranges
In-Reply-To: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390869573-27624-22-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Passing a NULL name for pin ranges will auto-generate standard names
for each pin. With common pinctrl driver now checking NULL name correctly,
consolidate mpp pins 0-15.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-dove.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 1823a1a7ec45..3bfea6ccb39d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -387,22 +387,7 @@ static int dove_twsi_ctrl_set(struct mvebu_mpp_ctrl *ctrl,
 }
 
 static struct mvebu_mpp_ctrl dove_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 0, "mpp0", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(1, 1, "mpp1", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(2, 2, "mpp2", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(3, 3, "mpp3", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(4, 4, "mpp4", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(5, 5, "mpp5", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(6, 6, "mpp6", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(7, 7, "mpp7", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(8, 8, "mpp8", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(9, 9, "mpp9", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(10, 10, "mpp10", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(11, 11, "mpp11", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(12, 12, "mpp12", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(13, 13, "mpp13", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(14, 14, "mpp14", dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(15, 15, "mpp15", dove_pmu_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 15, NULL, dove_pmu_mpp_ctrl),
 	MPP_FUNC_CTRL(16, 23, NULL, dove_mpp_ctrl),
 	MPP_FUNC_CTRL(24, 39, "mpp_camera", dove_mpp4_ctrl),
 	MPP_FUNC_CTRL(40, 45, "mpp_sdio0", dove_mpp4_ctrl),
-- 
1.8.5.2
