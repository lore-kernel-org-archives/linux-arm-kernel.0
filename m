From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:33 +1100
Subject: [PATCH 08/11] ep93xx: Move EP93XX_WATCHDOG_BASE define to driver
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-9-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EP93xx watchdog driver is the only user of this define, move it
there.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    2 --
 drivers/watchdog/ep93xx_wdt.c                   |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 387f745..225790d 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -127,7 +127,5 @@
 #define EP93XX_SYSCON_SYSCFG_LCSN1	(1<<0)
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
 
-#define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
-
 
 #endif
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 726b7df..82f648a 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -49,6 +49,7 @@ static unsigned long boot_status;
 #define WDT_IN_USE		0
 #define WDT_OK_TO_CLOSE		1
 
+#define EP93XX_WATCHDOG_BASE	EP93XX_APB_IOMEM(0x00140000)
 #define EP93XX_WDT_REG(x)	(EP93XX_WATCHDOG_BASE + (x))
 #define EP93XX_WDT_WATCHDOG	EP93XX_WDT_REG(0x00)
 #define EP93XX_WDT_WDSTATUS	EP93XX_WDT_REG(0x04)
-- 
1.7.0.4
