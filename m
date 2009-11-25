From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 25 Nov 2009 14:33:15 +0300
Subject: [PATCH] pxa/hx4700: actually use platform_lcd driver
Message-ID: <1259148795-10335-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e2c509c7e6 ([ARM] pxa/hx4700: use platform_lcd driver)
missed to actually register platform device for LCD.
It causes following GCC warning:
arch/arm/mach-pxa/hx4700.c:553: warning: 'hx4700_lcd' defined but not used

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-pxa/hx4700.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

This is a fix for 2.6.32.

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 83bd3c6..af44db2 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -820,6 +820,7 @@ static struct platform_device *devices[] __initdata = {
 	&gpio_keys,
 	&backlight,
 	&w3220,
+	&hx4700_lcd,
 	&egpio,
 	&bq24022,
 	&gpio_vbus,
-- 
1.6.3.4
