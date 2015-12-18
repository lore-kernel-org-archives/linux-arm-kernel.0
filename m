From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:37 +0100
Subject: [PATCH 24/69] clocksource/drivers/tegra2: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-24-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Due to the non portable code for the delay timer, this option is only
available for the ARM architecture.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 625d459..e33ed76 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -84,7 +84,10 @@ config SUN5I_HSTIMER
 	  Enables support the Sun5i timer.
 
 config TEGRA_TIMER
-	bool
+	bool "Tegra timer driver" if COMPILE_TEST
+	depends on ARM
+	help
+	  Enables support for the Tegra driver.
 
 config VT8500_TIMER
 	bool
-- 
1.9.1
