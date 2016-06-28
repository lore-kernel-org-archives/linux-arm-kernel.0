From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:51:34 +0200
Subject: [PATCH 76/92] clocksource/drivers/armv7m_systick: Add the
 COMPILE_TEST option
In-Reply-To: <577251A4.7030508@linaro.org>
References: <577251A4.7030508@linaro.org>
Message-ID: <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to increase the compilation test coverage, add the COMPILE_TEST
so the driver can be compiled even if it does not belong to the platform
or the architecture.

The io.h header inclusion is also added as it the driver does not compile
on UM platform.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig          | 2 +-
 drivers/clocksource/armv7m_systick.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0275b16..01ecd88 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -250,7 +250,7 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	 Use ARM global timer clock source as sched_clock
 
 config ARMV7M_SYSTICK
-	bool
+	bool "Support for the ARMv7M system time" if COMPILE_TEST
 	select CLKSRC_OF if OF
 	select CLKSRC_MMIO
 	help
diff --git a/drivers/clocksource/armv7m_systick.c b/drivers/clocksource/armv7m_systick.c
index e93af1f..a315491 100644
--- a/drivers/clocksource/armv7m_systick.c
+++ b/drivers/clocksource/armv7m_systick.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk.h>
-- 
1.9.1
