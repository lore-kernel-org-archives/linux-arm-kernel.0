From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 18 Apr 2018 12:51:40 +0200
Subject: [PATCH v4 3/6] clocksource/drivers: atmel-pit: make option silent
In-Reply-To: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
References: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
Message-ID: <20180418105143.3577-4-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To conform with the other option, make the ATMEL_PIT option silent so it
can be selected from the platform

Tested-by: Alexander Dahl <ada@thorsis.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 540892273a8d..cb635d5d7f42 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -384,8 +384,11 @@ config ARMV7M_SYSTICK
 	  This options enables support for the ARMv7M system timer unit
 
 config ATMEL_PIT
+	bool "Microchip ARM Periodic Interval Timer (PIT)" if COMPILE_TEST
 	select TIMER_OF if OF
-	def_bool SOC_AT91SAM9 || SOC_SAMA5
+	help
+	  This enables build of clocksource and clockevent driver for
+	  the integrated PIT in Microchip ARM SoCs.
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
-- 
2.17.0
