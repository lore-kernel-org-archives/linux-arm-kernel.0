From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Mar 2014 17:36:56 +0900
Subject: [PATCH] ARM: shmobile: APMU: Fix warnings due to improper printk
 formats
In-Reply-To: <cover.1394440471.git.horms+renesas@verge.net.au>
References: <cover.1394440471.git.horms+renesas@verge.net.au>
Message-ID: <56ff873122c4baab43df241c7701d043b8ec8a8e.1394440471.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Use the %pr printk specifier to print resource variables. This fixes
warnings on platforms where resource_size_t has a different size than
int.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 1da5a72..8cb641c 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -75,8 +75,7 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 	apmu_cpus[cpu].iomem = ioremap_nocache(res->start, resource_size(res));
 	apmu_cpus[cpu].bit = bit;
 
-	pr_debug("apmu ioremap %d %d 0x%08x 0x%08x\n", cpu, bit,
-		 res->start, resource_size(res));
+	pr_debug("apmu ioremap %d %d %pr\n", cpu, bit, res);
 }
 
 static struct {
-- 
1.8.5.2
