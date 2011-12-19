From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 14:24:57 +0100
Subject: [PATCH 2/7] s3c-hsudc: add __devinit to probe function
In-Reply-To: <201112191423.21461.heiko@sntech.de>
References: <201112191423.21461.heiko@sntech.de>
Message-ID: <201112191424.58081.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 4c1abb1..3e5673d 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -1260,7 +1260,7 @@ static struct usb_gadget_ops s3c_hsudc_gadget_ops = {
 	.vbus_draw	= s3c_hsudc_vbus_draw,
 };
 
-static int s3c_hsudc_probe(struct platform_device *pdev)
+static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-- 
1.7.5.4
