From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Feb 2010 15:30:34 -0800
Subject: [PATCH 09/11] omap: musb: remove unnecessary return
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Message-ID: <20100219233034.10559.33410.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <felipe.balbi@nokia.com>

trivial patch, no functional changes.

Cc: linux-usb at vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 4dfb66a..2221a6c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -103,10 +103,8 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	musb_plat.power = board_data->power >> 1;
 	musb_plat.mode = board_data->mode;
 
-	if (platform_device_register(&musb_device) < 0) {
+	if (platform_device_register(&musb_device) < 0)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
-		return;
-	}
 }
 
 #else
