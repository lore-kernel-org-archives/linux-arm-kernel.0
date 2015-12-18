From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:41 +0100
Subject: [PATCH 28/69] clocksource/drivers/asm9260: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-28-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index badef72..a658190 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -101,9 +101,11 @@ config CADENCE_TTC_TIMER
 	  Enables support for the cadence ttc driver.
 
 config ASM9260_TIMER
-	bool
+	bool "ASM9260 timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	select CLKSRC_OF
+	help
+	  Enables support for the ASM9260 timer.
 
 config CLKSRC_NOMADIK_MTU
 	bool
-- 
1.9.1
