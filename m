From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 21 Nov 2009 19:49:47 +0100
Subject: Fix backlight limiting
Message-ID: <20091121184947.GA2349@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have my trees quite modified in that area, testers welcome.

---

This should fix backlight limiting on 2.6.32-rc... 

Signed-off-by: Pavel Machek <pavel@ucw.cz>

Binary files arm.middle/mach-pxa/built-in.o and arm/mach-pxa/built-in.o differ
diff -ur arm.middle/mach-pxa/sharpsl_pm.c arm/mach-pxa/sharpsl_pm.c
--- a/arch/arm/mach-pxa/sharpsl_pm.c	2009-11-21 11:06:45.000000000 +0100
+++ b/arch/arm/mach-pxa/sharpsl_pm.c	2009-11-21 11:09:57.000000000 +0100
@@ -179,7 +179,6 @@
 	dev_dbg(sharpsl_pm.dev, "Battery: voltage: %d, status: %d, percentage: %d, time: %ld\n", voltage,
 			sharpsl_pm.battstat.mainbat_status, sharpsl_pm.battstat.mainbat_percent, jiffies);
 
-#ifdef CONFIG_BACKLIGHT_CORGI
 	/* If battery is low. limit backlight intensity to save power. */
 	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
 	    && ((sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_LOW)
@@ -192,7 +191,6 @@
 		sharpsl_pm.machinfo->backlight_limit(0);
 		sharpsl_pm.flags &= ~SHARPSL_BL_LIMIT;
 	}
-#endif
 
 	/* Suspend if critical battery level */
 	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
