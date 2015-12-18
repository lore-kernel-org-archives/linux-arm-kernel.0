From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:40 +0100
Subject: [PATCH 27/69] clocksource/drivers/cadence_ttc: Add the COMPILE_TEST
 option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-27-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

The driver depends on the common clock framework, thus the dependency added
on COMMON_CLK.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c2b87b4..badef72 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -95,7 +95,10 @@ config VT8500_TIMER
 	  Enables support for the VT8500 driver.
 
 config CADENCE_TTC_TIMER
-	bool
+	bool "Cadence TTC timer driver" if COMPILE_TEST
+	depends on COMMON_CLK
+	help
+	  Enables support for the cadence ttc driver.
 
 config ASM9260_TIMER
 	bool
-- 
1.9.1
