From: const@MakeLinux.com (Constantine Shulyupin)
Date: Mon,  8 Oct 2012 15:17:07 +0200
Subject: [PATCH] usb: remove CONFIG_USB_MUSB_HOST etc
Message-ID: <1349702227-24875-1-git-send-email-const@MakeLinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Constantine Shulyupin <const@MakeLinux.com>

Remove USB configuration in arch/arm/mach-davinci/usb.c accordingly 
CONFIG_USB_MUSB_OTG CONFIG_USB_MUSB_PERIPHERAL CONFIG_USB_MUSB_HOST 
and set MUSB_OTG configuration by default
because this configuration options are removed from Kconfig.

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
 
---
 arch/arm/mach-davinci/usb.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index f77b953..34509ff 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -42,14 +42,8 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data usb_data = {
-#if defined(CONFIG_USB_MUSB_OTG)
 	/* OTG requires a Mini-AB connector */
 	.mode           = MUSB_OTG,
-#elif defined(CONFIG_USB_MUSB_PERIPHERAL)
-	.mode           = MUSB_PERIPHERAL,
-#elif defined(CONFIG_USB_MUSB_HOST)
-	.mode           = MUSB_HOST,
-#endif
 	.clock		= "usb",
 	.config		= &musb_config,
 };
-- 
1.7.9.5
