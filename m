From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 24 Mar 2011 18:35:34 +0200
Subject: [PATCH 5/6] arm: mach-omap2: smartreflex: delete instance from
	sr_list on probe error
In-Reply-To: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1300984535-10530-5-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the probe fails, the node should be deleted from sr_list.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e72b419..c8cd1ef 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -954,6 +954,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	return ret;
 
 err_iounmap:
+	list_del(&sr_info->node);
 	iounmap(sr_info->base);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
-- 
1.5.6.5
