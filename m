From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 18 Apr 2013 11:18:19 +0800
Subject: [PATCH -next] [media] s5p-mfc: fix error return code in
 s5p_mfc_probe()
Message-ID: <CAPgLHd_TwmtoaE7T7e3fRKh4NTGhOYjQZv0G7nt-iSVMLz3XEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as returned elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index e810b1a..a5853fa 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1110,7 +1110,8 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 	}
 
 	if (pdev->dev.of_node) {
-		if (s5p_mfc_alloc_memdevs(dev) < 0)
+		ret = s5p_mfc_alloc_memdevs(dev);
+		if (ret < 0)
 			goto err_res;
 	} else {
 		dev->mem_dev_l = device_find_child(&dev->plat_dev->dev,
