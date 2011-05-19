From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 19 May 2011 14:13:19 +0200
Subject: [PATCH 2/2] spi/pl022: mark driver non-experimental
Message-ID: <1305807199-11739-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has no TODO, and is now used on several platforms:
ARM, U300, Ux500, SPEAr and more. So drop the EXPERIMENTAL
requirement.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/spi/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fc14b8d..fbd96b2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -271,8 +271,8 @@ config SPI_ORION
 	  This enables using the SPI master controller on the Orion chips.
 
 config SPI_PL022
-	tristate "ARM AMBA PL022 SSP controller (EXPERIMENTAL)"
-	depends on ARM_AMBA && EXPERIMENTAL
+	tristate "ARM AMBA PL022 SSP controller"
+	depends on ARM_AMBA
 	default y if MACH_U300
 	default y if ARCH_REALVIEW
 	default y if INTEGRATOR_IMPD1
-- 
1.7.3.2
