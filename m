From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:35 +0100
Subject: [PATCH 22/69] clocksource/drivers/sun4i: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-22-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 24a8d8d..67be8f4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -71,8 +71,10 @@ config ORION_TIMER
 	  Enables the support for the Orion timer driver
 
 config SUN4I_TIMER
+	bool "Sun4i timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
-	bool
+	help
+	  Enables support for the Sun4i timer.
 
 config SUN5I_HSTIMER
 	select CLKSRC_MMIO
-- 
1.9.1
