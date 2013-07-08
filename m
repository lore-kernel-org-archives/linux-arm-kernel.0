From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 8 Jul 2013 14:04:43 +0200
Subject: pali's n900 tree: fix compilation
Message-ID: <20130708120443.GA2158@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This fixes compilation w/o CONFIG_TWL4030_MADC.

Please apply :-).

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-omap2/board-rx51-compat.c b/arch/arm/mach-omap2/board-rx51-compat.c
index ceabe8b..f3a82a3 100644
--- a/arch/arm/mach-omap2/board-rx51-compat.c
+++ b/arch/arm/mach-omap2/board-rx51-compat.c
@@ -125,6 +125,7 @@ static long twl4030_madc_ioctl(struct file *filp, unsigned int cmd,
 	}
 
 	switch (cmd) {
+#ifdef CONFIG_TWL4030_MADC
 	case TWL4030_MADC_IOCX_ADC_RAW_READ: {
 		struct twl4030_madc_request req;
 		if (par.channel >= TWL4030_MADC_MAX_CHANNELS)
@@ -148,6 +149,7 @@ static long twl4030_madc_ioctl(struct file *filp, unsigned int cmd,
 		}
 		break;
 	}
+#endif
 	default:
 		return -EINVAL;
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
