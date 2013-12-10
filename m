From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 10 Dec 2013 20:16:07 +0100
Subject: [PATCH 1/6] clocksource: time-efm32: Select CLKSRC_MMIO
In-Reply-To: <52A767CB.3010501@linaro.org>
References: <52A767CB.3010501@linaro.org>
Message-ID: <1386702972-25565-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

The time-efm32 driver uses the clocksource MMIO functions.
Thus it needs to select CLKSRC_MMIO in Kconfig.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5c07a56..634c4d6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -75,6 +75,7 @@ config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 config CLKSRC_EFM32
 	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
 	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
+	select CLKSRC_MMIO
 	default ARCH_EFM32
 	help
 	  Support to use the timers of EFM32 SoCs as clock source and clock
-- 
1.7.9.5
