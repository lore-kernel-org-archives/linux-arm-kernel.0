From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 17 Dec 2011 20:25:40 +0100
Subject: [PATCH 2/7] s3c-hsudc: add __devinit to probe function
In-Reply-To: <201112172023.05519.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
Message-ID: <201112172025.40826.heiko@sntech.de>
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
1.7.2.3
