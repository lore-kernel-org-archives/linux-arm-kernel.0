From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:39:19 +0200
Subject: [PATCH v2 31/48] usb: gadget: s3c2410_udc: add ep capabilities support
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-32-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/s3c2410_udc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index 5d9aa81..eb3571e 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1691,6 +1691,8 @@ static struct s3c2410_udc memory = {
 			.name		= ep0name,
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP0_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 	},
@@ -1702,6 +1704,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep1-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1714,6 +1718,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep2-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1726,6 +1732,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep3-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1738,6 +1746,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep4-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
-- 
1.9.1
