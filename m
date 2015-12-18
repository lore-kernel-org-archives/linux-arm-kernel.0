From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:36 +0100
Subject: [PATCH 23/69] clocksource/drivers/sun5i: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-23-git-send-email-daniel.lezcano@linaro.org>
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
index 67be8f4..625d459 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -77,8 +77,11 @@ config SUN4I_TIMER
 	  Enables support for the Sun4i timer.
 
 config SUN5I_HSTIMER
+	bool "Sun5i timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
-	bool
+	depends on COMMON_CLK
+	help
+	  Enables support the Sun5i timer.
 
 config TEGRA_TIMER
 	bool
-- 
1.9.1
