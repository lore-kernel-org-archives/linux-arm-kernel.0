From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:34 +0100
Subject: [PATCH 21/69] clocksource/drivers/dw_apb: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-21-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 63a8c6f..24a8d8d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -33,7 +33,9 @@ config DIGICOLOR_TIMER
 	  Enables the support for the digicolor timer driver.
 
 config DW_APB_TIMER
-	bool
+	bool "DW APB timer driver" if COMPILE_TEST
+	help
+	  Enables the support for the dw_apb timer.
 
 config DW_APB_TIMER_OF
 	bool
-- 
1.9.1
