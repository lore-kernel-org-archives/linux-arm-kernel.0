From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:31 +0100
Subject: [PATCH 18/69] clocksource/drivers/meson6: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-18-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b6bb0a6..f6e71b7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -53,8 +53,10 @@ config ARMADA_370_XP_TIMER
 	  Enables the support for the Armada 370 and XP timer driver.
 
 config MESON6_TIMER
-	bool
+	bool "Meson6 timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
+	help
+	  Enables the support for the Meson6 timer driver.
 
 config ORION_TIMER
 	select CLKSRC_OF
-- 
1.9.1
