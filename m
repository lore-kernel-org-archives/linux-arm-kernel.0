From: jtzhou@marvell.com (Jett.Zhou)
Date: Mon, 10 Jun 2013 23:52:42 +0800
Subject: [V2 4/7] video: mmp: fix memcpy wrong size for mmp_addr issue
Message-ID: <1370879562-11342-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jing Xiang <jxiang@marvell.com>

Memcpy used wrong struct of mmp_win, fix it.

Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/video/mmp/hw/mmp_ctrl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 8836053..92a5f44 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -233,7 +233,7 @@ static int overlay_set_addr(struct mmp_overlay *overlay, struct mmp_addr *addr)
 	struct lcd_regs *regs = path_regs(overlay->path);
 
 	/* FIXME: assert addr supported */
-	memcpy(&overlay->addr, addr, sizeof(struct mmp_win));
+	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
 	writel(addr->phys[0], &regs->g_0);
 
 	return overlay->addr.phys[0];
-- 
1.7.0.4
