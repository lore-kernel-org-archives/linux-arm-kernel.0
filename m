From: akpm@linux-foundation.org (akpm at linux-foundation.org)
Date: Fri, 18 Sep 2009 12:44:19 -0700
Subject: [patch 3/3] spitz: fix touchscreen max presure
Message-ID: <200909181944.n8IJiJSQ008789@imap1.linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Machek <pavel@ucw.cz>

This fixes max_pressure for spitz's touchscreen, and is requirement
for getting reasonable pressure numbers from touchscreen driver.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Cc: Russell King <rmk@arm.linux.org.uk>                                        
Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mach-pxa/spitz.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/arm/mach-pxa/spitz.c~spitz-fix-touchscreen-max-presure arch/arm/mach-pxa/spitz.c
--- a/arch/arm/mach-pxa/spitz.c~spitz-fix-touchscreen-max-presure
+++ a/arch/arm/mach-pxa/spitz.c
@@ -296,6 +296,7 @@ static struct ads7846_platform_data spit
 	.vref_delay_usecs	= 100,
 	.x_plate_ohms		= 419,
 	.y_plate_ohms		= 486,
+	.pressure_max		= 1024,
 	.gpio_pendown		= SPITZ_GPIO_TP_INT,
 	.wait_for_sync		= spitz_wait_for_hsync,
 };
_
