From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Jan 2010 21:31:04 +0100
Subject: [patch] fix strange characters in zaurus gpio .desc
Message-ID: <20100107203104.GA22681@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Hrubis <metan@ucw.cz>
    
Somehow, strange characters made their way zaurus gpio .desc
fields. Fix it.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -389,13 +389,13 @@ static struct gpio_keys_button spitz_gpio_keys[] = {
 		.type	= EV_SW,
 		.code	= 0,
 		.gpio	= SPITZ_GPIO_SWA,
-		.desc	= "???Display Down",
+		.desc	= "Display Down",
 	},
 	{
 		.type	= EV_SW,
 		.code	= 1,
 		.gpio	= SPITZ_GPIO_SWB,
-		.desc	= "???Lid Closed",
+		.desc	= "Lid Closed",
 	},
 };
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
