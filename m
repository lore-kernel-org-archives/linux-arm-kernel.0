From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Aug 2013 16:35:52 +0100
Subject: [PATCH] power/reset: Make vexpress driver depend on required
 infrastructure
In-Reply-To: <20130815114401.GD23006@n2100.arm.linux.org.uk>
References: <20130815114401.GD23006@n2100.arm.linux.org.uk>
Message-ID: <1376580952-21677-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM Versatile Express reset driver requires platform-specific
config infrastructure to be present in the kernel. When
VEXPRESS_CONFIG is not selected, the build will fail like this:

drivers/built-in.o: In function `vexpress_reset_do.clone.0':
iio-trig-interrupt.c:(.text+0x1aff38): undefined reference to `__vexpress_config_func_get'
iio-trig-interrupt.c:(.text+0x1aff4c): undefined reference to `vexpress_config_write'

Added required dependency to the Kconfig entry.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ee039dc..26d79df 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -34,7 +34,7 @@ config POWER_RESET_RESTART
 config POWER_RESET_VEXPRESS
 	bool "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
-	depends on POWER_RESET
+	depends on POWER_RESET && VEXPRESS_CONFIG
 	help
 	  Power off and reset support for the ARM Ltd. Versatile
 	  Express boards.
-- 
1.8.1.2
