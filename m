From: belensarabia@gmail.com (Belen Sarabia)
Date: Sat, 25 Mar 2017 16:56:18 +0100
Subject: [PATCH] mailbox: rockchip: Delete redundant return value check of
 platform_get_resource()
Message-ID: <20170325155618.GA2806@belen-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete redundant error handling on the result to platform_get_resource() when the value is
passed to devm_ioremap_resource().

Signed-off-by: Belen Sarabia <belensarabia@gmail.com>
---
 drivers/mailbox/rockchip-mailbox.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index d702a20..4dae133 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -205,9 +205,6 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
 	mb->mbox.txdone_irq = true;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
 	mb->mbox_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mb->mbox_base))
 		return PTR_ERR(mb->mbox_base);
-- 
1.9.1
