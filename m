From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:47 +0200
Subject: [PATCH 44/48] clocksource: atmel-pit: allow unselecting ATMEL_PIT
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-45-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new TCB clocksource driver, atmel platforms are now able to boot
without the PIT driver. Allow unselecting it.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1860f6f9b380..c651661bf43c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -251,7 +251,14 @@ config ARMV7M_SYSTICK
 
 config ATMEL_PIT
 	select CLKSRC_OF if OF
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
 	bool
-- 
2.8.1
