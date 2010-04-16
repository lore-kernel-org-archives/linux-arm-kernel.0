From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 16 Apr 2010 15:12:45 +0200
Subject: spitz 2.6.34-rc4: fix On/off key name to fix warning during boot
Message-ID: <20100416131245.GA1306@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On/Off contains slash in the name, which causes warning during boot.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- ./arch/arm/mach-pxa/spitz.c	2010-03-21 22:09:12.000000000 +0100
+++ ./arch/arm/mach-pxa/spitz.c	2010-04-16 03:45:07.000000000 +0200
@@ -363,7 +363,7 @@
 		.type	= EV_PWR,
 		.code	= KEY_SUSPEND,
 		.gpio	= SPITZ_GPIO_ON_KEY,
-		.desc	= "On/Off",
+		.desc	= "On Off",
 		.wakeup	= 1,
 	},
 	/* Two buttons detecting the lid state */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
