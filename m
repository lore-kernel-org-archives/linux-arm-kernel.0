From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 23 Nov 2009 11:45:25 -0500
Subject: arm/common/scoop.c: use resource_size()
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5BBB@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use resource_size() macro for ioremap.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 7713a08..f598035 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -193,7 +193,7 @@ static int __devinit scoop_probe(struct platform_device *pdev)
 	spin_lock_init(&devptr->scoop_lock);
 
 	inf = pdev->dev.platform_data;
-	devptr->base = ioremap(mem->start, mem->end - mem->start + 1);
+	devptr->base = ioremap(mem->start, resource_size(mem));
 
 	if (!devptr->base) {
 		ret = -ENOMEM; 
