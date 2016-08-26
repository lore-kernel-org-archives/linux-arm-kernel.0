From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 26 Aug 2016 14:25:25 +0000
Subject: [PATCH -next] drm/sun4i: Remove redundant dev_err call in
 sun4i_tcon_init_regmap()
Message-ID: <1472221525-27706-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 2145ecf..9180e7e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -374,10 +374,8 @@ static int sun4i_tcon_init_regmap(struct device *dev,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs)) {
-		dev_err(dev, "Couldn't map the TCON registers\n");
+	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-	}
 
 	tcon->regs = devm_regmap_init_mmio(dev, regs,
 					   &sun4i_tcon_regmap_config);
