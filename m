From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 6 Feb 2013 11:28:13 +0530
Subject: [PATCH 5/5] usb: omap_control_usb: fix compile warning
In-Reply-To: <1360130294-5976-1-git-send-email-kishon@ti.com>
References: <1360130294-5976-1-git-send-email-kishon@ti.com>
Message-ID: <1360130294-5976-6-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

When CONFIG_OMAP_CONTROL_USB isn't enabled,
there's a compile warning stating that a
particular function isn't a prototype.

Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/usb/omap_control_usb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/omap_control_usb.h b/include/linux/usb/omap_control_usb.h
index f306db7..27b5b8c 100644
--- a/include/linux/usb/omap_control_usb.h
+++ b/include/linux/usb/omap_control_usb.h
@@ -70,7 +70,7 @@ extern void omap_control_usb3_phy_power(struct device *dev, bool on);
 extern void omap_control_usb_set_mode(struct device *dev,
 	enum omap_control_usb_mode mode);
 #else
-static inline struct device *omap_get_control_dev()
+static inline struct device *omap_get_control_dev(void)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
1.7.10.4
