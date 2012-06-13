From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Jun 2012 03:15:12 -0700
Subject: [PATCH 2/2] ARM: OMAP2: Fix tusb6010 GPIO interrupt for n8x0
In-Reply-To: <20120613101303.18645.83320.stgit@muffinssi.local>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
Message-ID: <20120613101512.18645.12865.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's one more gpio_to_irq conversion that we missed
earlier. Tested with n800 in gadget mode using USB_ETH.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index db84a46..805bea6 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -300,7 +300,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		printk(error, 3, status);
 		return status;
 	}
-	tusb_resources[2].start = irq + IH_GPIO_BASE;
+	tusb_resources[2].start = gpio_to_irq(irq);
 
 	/* set up memory timings ... can speed them up later */
 	if (!ps_refclk) {
