From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sun, 13 Oct 2013 07:58:39 +0200
Subject: [PATCH] [media] s5p-mfc: remove deprecated IRQF_DISABLED
Message-ID: <1381643919-9016-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 084263d..4660d24 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1101,7 +1101,7 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 	}
 	dev->irq = res->start;
 	ret = devm_request_irq(&pdev->dev, dev->irq, s5p_mfc_irq,
-					IRQF_DISABLED, pdev->name, dev);
+					0, pdev->name, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to install irq (%d)\n", ret);
 		goto err_res;
-- 
1.8.1.2
