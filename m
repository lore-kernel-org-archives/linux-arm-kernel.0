From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 04:14:18 +0000
Subject: [PATCH] ARM: SAMSUNG: Use PLAT_SAMSUNG instead of PLAT_S3C
In-Reply-To: <1264738459-1972-1-git-send-email-ben-linux@fluff.org>
References: <1264738459-1972-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264738459-1972-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the development process, it is hoped PLAT_S3C is either removed
from all of the PLAT_SAMSUNG derived platforms or removed entirely. It is
also better to use PLAT_SAMSUNG as this is the current base of all Samsung
devices.

Change the two places that use PLAT_S3C to use PLAT_SAMSUNG

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/serial/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 1d47c77..b2157c3 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -447,7 +447,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on ARM && PLAT_S3C
+	depends on ARM && PLAT_SAMSUNG
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
@@ -464,7 +464,7 @@ config SERIAL_SAMSUNG_UARTS_4
 
 config SERIAL_SAMSUNG_UARTS
 	int
-	depends on ARM && PLAT_S3C
+	depends on ARM && PLAT_SAMSUNG
 	default 2 if ARCH_S3C2400
 	default 4 if SERIAL_SAMSUNG_UARTS_4
 	default 3
-- 
1.6.0.4
