From: nm@ti.com (Nishanth Menon)
Date: Wed,  2 Mar 2011 16:25:24 +0530
Subject: [PATCH v2 11/18] omap3+: sr: disable interrupt by default
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Message-ID: <1299063331-27968-12-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will enable and disable interrupt on a need basis in the class
driver. we need to keep the irq disabled by default else the
forceupdate or vcbypass events could trigger events that we dont
need/expect to handle.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a4e9f2d..8cad92d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -281,6 +281,7 @@ static int sr_late_init(struct omap_sr *sr_info)
 				IRQF_DISABLED, name, (void *)sr_info);
 		if (ret)
 			goto error;
+		disable_irq(sr_info->irq);
 	}
 
 	if (pdata && pdata->enable_on_init)
-- 
1.7.1
