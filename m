From: jhnikula@gmail.com (Jarkko Nikula)
Date: Mon, 28 Feb 2011 16:47:15 +0200
Subject: [PATCH resend] omap: Fix linker error in
	drivers/video/omap/lcd_2430sdp.c
In-Reply-To: <20110224212644.GN20560@atomide.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
	<1298232248-347-1-git-send-email-jhnikula@gmail.com>
	<20110224212644.GN20560@atomide.com>
Message-ID: <20110228164715.e34a965e.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Feb 2011 13:26:44 -0800
Tony Lindgren <tony@atomide.com> wrote:

> We should avoid selecting driver related things, otherwise we can never
> build a tiny kernel with initramfs with everything as modules.
> 
> Can you see if adding depends to the LCD panel option does the trick
> instead?
> 
True and as lcd_2430sdp.c is not compiled without CONFIG_FB_OMAP a hack
below should work a bit better.

What would you think Tomi?

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 083c8fe..c981249 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -5,6 +5,7 @@ config FB_OMAP
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select TWL4030_CORE if MACH_OMAP_2430SDP
 	help
           Frame buffer driver for OMAP based boards.

-- 
Jarkko
