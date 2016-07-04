From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Mon,  4 Jul 2016 15:08:07 +0000
Subject: [PATCH -next] ASoC: sunxi: remove redundant dev_err call in
 sun4i_i2s_probe()
Message-ID: <1467644887-10796-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index fab5234..687a8f8 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -599,10 +599,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs)) {
-		dev_err(&pdev->dev, "Can't request IO region\n");
+	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
