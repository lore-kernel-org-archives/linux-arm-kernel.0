From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 13:18:21 +0300
Subject: [PATCH v2 1/9] usb: phy: nop: Add gpio_reset to platform data
In-Reply-To: <1376561909-4406-1-git-send-email-rogerq@ti.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
Message-ID: <1376561909-4406-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO number of the RESET line can be passed to the
driver using the gpio_reset member.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/usb/nop-usb-xceiv.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
index 148d351..1e57acb 100644
--- a/include/linux/usb/nop-usb-xceiv.h
+++ b/include/linux/usb/nop-usb-xceiv.h
@@ -9,7 +9,9 @@ struct nop_usb_xceiv_platform_data {
 
 	/* if set fails with -EPROBE_DEFER if can't get regulator */
 	unsigned int needs_vcc:1;
-	unsigned int needs_reset:1;
+	unsigned int needs_reset:1; /* Deprecated */
+
+	int gpio_reset;
 };
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
-- 
1.7.4.1
