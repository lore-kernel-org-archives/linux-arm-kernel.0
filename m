From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  5 Jan 2018 15:30:03 +0100
Subject: [PATCH v2 3/6] clocksource/drivers: atmel-pit: allow unselecting
 ATMEL_PIT
In-Reply-To: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
References: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
Message-ID: <20180105143006.5369-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new TCB clocksource driver, atmel platforms are now able to boot
without the PIT driver. Allow unselecting it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5609572e0236..55ccfa0ba63b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -381,7 +381,14 @@ config ARMV7M_SYSTICK
 
 config ATMEL_PIT
 	select TIMER_OF if OF
-	def_bool SOC_AT91SAM9 || SOC_SAMA5
+	bool "Atmel Periodic Interval Timer (PIT)"
+	depends on SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAMA5
+	help
+	  Select this to get a clocksource based on the Atmel Periodic Interval
+	  Timer. It has a relatively low resolution and the TC Block clocksource
+	  should be preferred.
+	  It also provides a clock event device.
 
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
-- 
2.15.1
