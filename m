From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:29 +0800
Subject: [PATCH 01/14] usb: udc-core: introduce vbus_active for struct
 usb_gadget
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-2-git-send-email-peter.chen@freescale.com>
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
