From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:06 +0200
Subject: [PATCH v3 19/46] usb: gadget: lpc32xx_udc: add ep capabilities support
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-20-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 3b6a785..00b5006 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -2575,6 +2575,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep0",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 0,
@@ -2586,6 +2588,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep1-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 2,
@@ -2597,6 +2601,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep2-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 4,
@@ -2608,6 +2614,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep3-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 6,
@@ -2619,6 +2627,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep4-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 8,
@@ -2630,6 +2640,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep5-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 10,
@@ -2641,6 +2653,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep6-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 12,
@@ -2652,6 +2666,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep7-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 14,
@@ -2663,6 +2679,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep8-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 16,
@@ -2674,6 +2692,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep9-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 18,
@@ -2685,6 +2705,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep10-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 20,
@@ -2696,6 +2718,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep11-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 22,
@@ -2707,6 +2731,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep12-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 24,
@@ -2718,6 +2744,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep13-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 26,
@@ -2729,6 +2757,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep14-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 28,
@@ -2740,6 +2770,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep15-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 30,
-- 
1.9.1
