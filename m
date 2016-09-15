From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 15 Sep 2016 03:25:58 +0000
Subject: [PATCH -next] drm/sun4i: backend: remove redundant dev_err call in
 sun4i_backend_bind()
Message-ID: <1473909958-30216-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 91a7022..fcd4e91 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -288,10 +288,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs)) {
-		dev_err(dev, "Couldn't map the backend registers\n");
+	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-	}
 
 	backend->regs = devm_regmap_init_mmio(dev, regs,
 					      &sun4i_backend_regmap_config);
