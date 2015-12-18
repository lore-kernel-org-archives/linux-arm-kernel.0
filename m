From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:32 +0100
Subject: [PATCH 19/69] clocksource/drivers/orion: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-19-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

The driver is using the atomic_io API which is not portable, so the
compilation is restricted to ARM only.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f6e71b7..68a63b2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -59,9 +59,12 @@ config MESON6_TIMER
 	  Enables the support for the Meson6 timer driver.
 
 config ORION_TIMER
+	bool "Orion timer driver" if COMPILE_TEST
+	depends on ARM
 	select CLKSRC_OF
 	select CLKSRC_MMIO
-	bool
+	help
+	  Enables the support for the Orion timer driver
 
 config SUN4I_TIMER
 	select CLKSRC_MMIO
-- 
1.9.1
