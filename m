From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 12 Mar 2013 17:03:17 +0800
Subject: [RFC PATCH 1/3] usb: udc-core: introduce vbus_active for struct
 usb_gadget
Message-ID: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is an vbus session event for udc driver, let the
udc core know vbus's status.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 include/linux/usb/gadget.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 2e297e8..7e373a2 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -531,6 +531,7 @@ struct usb_gadget {
 	unsigned			b_hnp_enable:1;
 	unsigned			a_hnp_support:1;
 	unsigned			a_alt_hnp_support:1;
+	unsigned			vbus_active:1;
 	const char			*name;
 	struct device			dev;
 	unsigned			out_epnum;
-- 
1.7.0.4
