From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon, 12 May 2014 14:56:28 +0200
Subject: [PATCH] phy: exynos-mipi-video: fix check on array index
Message-ID: <1399899388-13101-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phys array is of size EXYNOS_MIPI_PHYS_NUM. Trying to access the
index EXYNOS_MIPI_PHYS_NUM should return an error.

Fixes: 069d2e26e9d6 "phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs"

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 drivers/phy/phy-exynos-mipi-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
index 7f139326a642..ff026689358c 100644
--- a/drivers/phy/phy-exynos-mipi-video.c
+++ b/drivers/phy/phy-exynos-mipi-video.c
@@ -101,7 +101,7 @@ static struct phy *exynos_mipi_video_phy_xlate(struct device *dev,
 {
 	struct exynos_mipi_video_phy *state = dev_get_drvdata(dev);
 
-	if (WARN_ON(args->args[0] > EXYNOS_MIPI_PHYS_NUM))
+	if (WARN_ON(args->args[0] >= EXYNOS_MIPI_PHYS_NUM))
 		return ERR_PTR(-ENODEV);
 
 	return state->phys[args->args[0]].phy;
-- 
1.9.1
