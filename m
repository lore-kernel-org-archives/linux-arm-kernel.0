From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:39:29 +0200
Subject: [PATCH v2 41/48] usb: gadget: add 'ep_match' callback to
 usb_gadget_ops
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-42-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This callback will be called by epautoconf to allow UDC driver match best
endpoint for specific descriptor. It's intended to supply mechanism which
allows to get rid of chip-specific endpoint matching code from epautoconf.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 include/linux/usb/gadget.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e6cbc25..0041bb9 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -534,6 +534,9 @@ struct usb_gadget_ops {
 	int	(*udc_start)(struct usb_gadget *,
 			struct usb_gadget_driver *);
 	int	(*udc_stop)(struct usb_gadget *);
+	struct usb_ep *(*match_ep)(struct usb_gadget *,
+			struct usb_endpoint_descriptor *,
+			struct usb_ss_ep_comp_descriptor *);
 };
 
 /**
-- 
1.9.1
