From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun,  5 Feb 2017 16:25:38 +0000
Subject: [PATCH -next] usb: mtu3: remove redundant dev_err call in
 get_ssusb_rscs()
Message-ID: <20170205162538.25781-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 19a345d..4559baa 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -252,10 +252,8 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ippc");
 	ssusb->ippc_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ssusb->ippc_base)) {
-		dev_err(dev, "failed to map memory for ippc\n");
+	if (IS_ERR(ssusb->ippc_base))
 		return PTR_ERR(ssusb->ippc_base);
-	}
 
 	ssusb->dr_mode = usb_get_dr_mode(dev);
 	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN) {
