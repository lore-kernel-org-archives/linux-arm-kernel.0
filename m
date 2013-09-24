From: rogerq@ti.com (Roger Quadros)
Date: Tue, 24 Sep 2013 11:53:47 +0300
Subject: [PATCH v3 01/10] usb: phy: generic: Add gpio_reset to platform data
In-Reply-To: <1380012836-29900-1-git-send-email-rogerq@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
Message-ID: <1380012836-29900-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO number of the RESET line can be passed to the
driver using the gpio_reset member.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/usb/usb_phy_gen_xceiv.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/usb_phy_gen_xceiv.h b/include/linux/usb/usb_phy_gen_xceiv.h
index f9a7e7b..42f3b71 100644
--- a/include/linux/usb/usb_phy_gen_xceiv.h
+++ b/include/linux/usb/usb_phy_gen_xceiv.h
@@ -9,7 +9,8 @@ struct usb_phy_gen_xceiv_platform_data {
 
 	/* if set fails with -EPROBE_DEFER if can't get regulator */
 	unsigned int needs_vcc:1;
-	unsigned int needs_reset:1;
+	unsigned int needs_reset:1;	/* deprecated */
+	int gpio_reset;
 };
 
 #if IS_ENABLED(CONFIG_NOP_USB_XCEIV)
-- 
1.7.4.1
