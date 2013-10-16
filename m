From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 16 Oct 2013 19:03:45 +0200
Subject: [PATCH] phy: exynos-mipi-video: Fix phy_power_off() callback
In-Reply-To: <1381940896-9355-1-git-send-email-kishon@ti.com>
References: <1381940896-9355-1-git-send-email-kishon@ti.com>
Message-ID: <1381943025-1036-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix argument passed to the register setup helper function so
the phy is actually disabled. Now due to cut&paste error 1 is
passed to both phy_power_on() and phy_power_off().

Reported by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---

This fixes a cut&paste typo which snicked in while doing very last
adaptation to latest version of the phy framework.

Thanks,
Sylwester
---
 drivers/phy/phy-exynos-mipi-video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
index b73b86a..0c5efab 100644
--- a/drivers/phy/phy-exynos-mipi-video.c
+++ b/drivers/phy/phy-exynos-mipi-video.c
@@ -93,7 +93,7 @@ static int exynos_mipi_video_phy_power_off(struct phy *phy)
 	struct video_phy_desc *phy_desc = phy_get_drvdata(phy);
 	struct exynos_mipi_video_phy *state = to_mipi_video_phy(phy_desc);
 
-	return __set_phy_state(state, phy_desc->index, 1);
+	return __set_phy_state(state, phy_desc->index, 0);
 }
 
 static struct phy *exynos_mipi_video_phy_xlate(struct device *dev,
-- 
1.7.9.5
