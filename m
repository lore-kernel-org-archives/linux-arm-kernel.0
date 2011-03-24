From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 24 Mar 2011 18:35:30 +0200
Subject: [PATCH 1/6] arm: mach-omap2: omap_l3_smx: fix request_irq() error path
Message-ID: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug irq should be freed on the error path.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 265bff3..02528cb 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -273,6 +273,7 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 	goto err0;
 
 err4:
+	free_irq(l3->debug_irq, l3);
 err3:
 	iounmap(l3->rt);
 err2:
-- 
1.5.6.5
