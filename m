From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 3 Oct 2017 10:40:05 +0200
Subject: [PATCH] ARM: vexpress/spc: Delete an error message for a failed
 memory allocation in two functions
Message-ID: <557666e2-45b6-8f47-2fc9-756bd7f23541@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Oct 2017 10:30:07 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-vexpress/spc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index fe488523694c..21c064267af5 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -451,10 +451,8 @@ int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid, int irq)
 {
 	int ret;
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		pr_err(SPCLOG "unable to allocate mem\n");
+	if (!info)
 		return -ENOMEM;
-	}
 
 	info->baseaddr = baseaddr;
 	info->a15_clusid = a15_clusid;
@@ -535,10 +533,8 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)
 	struct clk_spc *spc;
 
 	spc = kzalloc(sizeof(*spc), GFP_KERNEL);
-	if (!spc) {
-		pr_err("could not allocate spc clk\n");
+	if (!spc)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spc->hw.init = &init;
 	spc->cluster = topology_physical_package_id(cpu_dev->id);
-- 
2.14.2
