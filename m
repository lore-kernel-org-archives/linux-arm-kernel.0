From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 16:57:21 +0100
Subject: [PATCH 5/6] Input: Kconfig: remove dependency for atmel_tsadcc driver
In-Reply-To: <cover.1331826095.git.nicolas.ferre@atmel.com>
References: <cover.1331826095.git.nicolas.ferre@atmel.com>
Message-ID: <531cf3ace390f3673a73792f15f9c7cd6aeb273d.1331826095.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to select this driver for newer SoCs.
Keep dependency on AT91 because of the use of an header
file located in include/mach directory.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/input/touchscreen/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4af2a18..3900c64 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -432,10 +432,10 @@ config TOUCHSCREEN_TOUCHWIN
 
 config TOUCHSCREEN_ATMEL_TSADCC
 	tristate "Atmel Touchscreen Interface"
-	depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
+	depends on ARCH_AT91
 	help
 	  Say Y here if you have a 4-wire touchscreen connected to the
-          ADC Controller on your Atmel SoC (such as the AT91SAM9RL).
+          ADC Controller on your Atmel SoC.
 
 	  If unsure, say N.
 
-- 
1.7.9
