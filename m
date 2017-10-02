From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 2 Oct 2017 18:45:50 +0200
Subject: [PATCH] ARM: footbridge: Delete an error message for a failed memory
 allocation in dc21285_setup()
Message-ID: <a7a12144-a9fa-9c38-ff2f-c8f70ca451a1@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Oct 2017 18:36:56 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-footbridge/dc21285.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 96a3d73ef4bf..e40c78358b16 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -258,10 +258,8 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 		return 0;
 
 	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
-	if (!res) {
-		printk("out of memory for root bus resources");
+	if (!res)
 		return 0;
-	}
 
 	res[0].flags = IORESOURCE_MEM;
 	res[0].name  = "Footbridge non-prefetch";
-- 
2.14.2
