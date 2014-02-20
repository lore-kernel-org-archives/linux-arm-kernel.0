From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 20 Feb 2014 09:55:14 +0100
Subject: [PATCH] ARM: efm32: drop selecting CLKSRC_MMIO
Message-ID: <1392886514-6577-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLKSRC_MMIO is needed on efm32 because the clocksource driver
(CLKSRC_EFM32) uses clocksource_mmio_init() and
clocksource_mmio_readl_up(). Since commit 09ca27579ee5 (clocksource:
time-efm32: Select CLKSRC_MMIO) CLKSRC_EFM32 does the necessary select
itself and ARCH_EFM32 doesn't need to select it explicitly any more.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5e0fa693fbd..44881c07883b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -421,9 +421,6 @@ config ARCH_EFM32
 	depends on !MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_NVIC
-	# CLKSRC_MMIO is wrong here, but needed until a proper fix is merged,
-	# i.e. CLKSRC_EFM32 selecting CLKSRC_MMIO
-	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select COMMON_CLK
 	select CPU_V7M
-- 
1.8.5.2
