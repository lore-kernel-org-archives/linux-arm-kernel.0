From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:30 +0100
Subject: [PATCH 17/69] clocksource/drivers/armada-370-xp: Add the COMPILE_TEST
 option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-17-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Due to the non portable 'delay' code, the compilation is restricted to the
ARM architecture only.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0c06103..b6bb0a6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -46,8 +46,11 @@ config ROCKCHIP_TIMER
 	  Enables the support for the rockchip timer driver.
 
 config ARMADA_370_XP_TIMER
-	bool
+	bool "Armada 370 and XP timer driver" if COMPILE_TEST
+	depends on ARM
 	select CLKSRC_OF
+	help
+	  Enables the support for the Armada 370 and XP timer driver.
 
 config MESON6_TIMER
 	bool
-- 
1.9.1
