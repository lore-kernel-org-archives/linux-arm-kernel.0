From: s-anna@ti.com (Suman Anna)
Date: Mon, 16 Mar 2015 20:14:03 -0500
Subject: [PATCH 2/2] ARM: OMAP: dmtimer: disable pm runtime on remove
In-Reply-To: <1426554843-42641-1-git-send-email-s-anna@ti.com>
References: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Message-ID: <1426554843-42641-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the pm_runtime of the device upon remove. This is
added to balance the pm_runtime_enable() invoked in the probe.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/dmtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f32c74c0e1de..8ca94d379bc3 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -910,6 +910,8 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 		}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
+	pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
-- 
2.3.2
