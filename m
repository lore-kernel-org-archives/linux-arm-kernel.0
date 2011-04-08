From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 8 Apr 2011 08:26:46 +0200
Subject: 2.6.39-rc2 on zaurus: does not build, does not boot
Message-ID: <20110408062646.GA1472@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Build fix is below. Maybe it is pending in the trees somewhere
already...

Boot stops just after mounting root filesystem; cursor stops
flashing. (Any idea what goes on there?)

								Pavel

--- ./drivers/video.ofic/pxafb.c	2011-04-06 15:19:51.000000000 +0200
+++ ./drivers/video/pxafb.c	2011-04-07 06:20:20.000000000 +0200
@@ -1648,7 +1648,7 @@
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if (!fbi->overlay[0].usage && !fbi->overlay[1].usage)
+//		if (!fbi->overlay[0].usage && !fbi->overlay[1].usage)
 			set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
 		break;
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
