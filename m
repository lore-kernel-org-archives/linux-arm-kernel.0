From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 27 Jan 2011 10:11:35 -0700
Subject: [PATCH] scoop.c: use resource_size()
Message-ID: <201101271011.35316.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use resource_size() instead of calculating the size by hand.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index c11af1e..a07b0e7 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -193,7 +193,7 @@ static int __devinit scoop_probe(struct platform_device *pdev)
 	spin_lock_init(&devptr->scoop_lock);
 
 	inf = pdev->dev.platform_data;
-	devptr->base = ioremap(mem->start, mem->end - mem->start + 1);
+	devptr->base = ioremap(mem->start, resource_size(mem));
 
 	if (!devptr->base) {
 		ret = -ENOMEM;
