From: gomonovych@gmail.com (Vasyl Gomonovych)
Date: Mon, 20 Nov 2017 23:46:47 +0100
Subject: [PATCH] [media] c8sectpfe: Use resource_size function on memory
 resource
Message-ID: <1511218007-3577-1-git-send-email-gomonovych@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To adapt fei->sram_size calculation via resource_size for memory size
calculation before, in fei->sram = devm_ioremap_resource(dev, res).
And make memory initialization range in
memset_io for fei->sram appropriate

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 59280ac31937..283f7289aaa1 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -691,7 +691,7 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 	if (IS_ERR(fei->sram))
 		return PTR_ERR(fei->sram);
 
-	fei->sram_size = res->end - res->start;
+	fei->sram_size = resource_size(res);
 
 	fei->idle_irq = platform_get_irq_byname(pdev, "c8sectpfe-idle-irq");
 	if (fei->idle_irq < 0) {
-- 
1.9.1
