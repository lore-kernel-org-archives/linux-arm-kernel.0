From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 06 Sep 2014 18:33:33 +0530
Subject: [PATCH] clk: samsung: exynos3250: fix mout_cam_blk parent list
Message-ID: <1410008613-20861-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per user manual of Exynos3250 SRC_CAM can select
div_cam_blk_320 if it's value is 0xC, so placing
div_cam_blk_320 at proper index in parent list of mout_cam_blk.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index e1cb464..ba8f073f 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -248,6 +248,7 @@ PNAME(group_sclk_cam_blk_p)	= { "xxti", "xusbxti",
 				    "none", "none", "none",
 				    "none", "div_mpll_pre",
 				    "mout_epll_user", "mout_vpll",
+				    "none", "none", "none",
 				    "div_cam_blk_320", };
 PNAME(group_sclk_fimd0_p)	= { "xxti", "xusbxti",
 				    "m_bitclkhsdiv4_2l", "none",
-- 
1.7.9.5
