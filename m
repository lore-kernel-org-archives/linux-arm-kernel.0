From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 Nov 2014 17:06:32 +0100
Subject: [PATCH 04/11] ARM: at91/Kconfig: remove ARCH_AT91RM9200 option for
 drivers
In-Reply-To: <cover.1417103399.git.nicolas.ferre@atmel.com>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
Message-ID: <c7dbeffc8a6a4ec88b64e76da01c770526bf4358.1417103399.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The precise selection is useless, so we simply remove these dependencies.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/net/ethernet/cadence/Kconfig | 2 +-
 drivers/rtc/Kconfig                  | 2 +-
 drivers/watchdog/Kconfig             | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 9e089d24466e..3564fe9d3f69 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -22,7 +22,7 @@ if NET_CADENCE
 
 config ARM_AT91_ETHER
 	tristate "AT91RM9200 Ethernet support"
-	depends on HAS_DMA && (ARCH_AT91RM9200 || COMPILE_TEST)
+	depends on HAS_DMA && (ARCH_AT91 || COMPILE_TEST)
 	select MACB
 	---help---
 	  If you wish to compile a kernel for the AT91RM9200 and enable
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index aa96e375915d..0b704889bf91 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1110,7 +1110,7 @@ config RTC_DRV_AT91RM9200
 
 config RTC_DRV_AT91SAM9
 	tristate "AT91SAM9x/AT91CAP9 RTT as RTC"
-	depends on ARCH_AT91 && !ARCH_AT91RM9200
+	depends on ARCH_AT91
 	help
 	  RTC driver for the Atmel AT91SAM9x and AT91CAP9 internal RTT
 	  (Real Time Timer). These timers are powered by the backup power
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index d0107d424ee4..08f41add1461 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -154,14 +154,14 @@ config ARM_SP805_WATCHDOG
 
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
-	depends on ARCH_AT91RM9200
+	depends on SOC_AT91RM9200
 	help
 	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
 	  system when the timeout is reached.
 
 config AT91SAM9X_WATCHDOG
 	tristate "AT91SAM9X / AT91CAP9 watchdog"
-	depends on ARCH_AT91 && !ARCH_AT91RM9200
+	depends on ARCH_AT91
 	select WATCHDOG_CORE
 	help
 	  Watchdog timer embedded into AT91SAM9X and AT91CAP9 chips. This will
-- 
2.1.3
