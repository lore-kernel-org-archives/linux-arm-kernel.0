From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  3 Mar 2016 10:39:58 +0900
Subject: [PATCH] bus: simple-pm-bus: Use ARCH_RENESAS
Message-ID: <1456969198-20365-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 v4.5-rc1

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 129d47bcc5fc..c10c6def1565 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -110,7 +110,7 @@ config OMAP_OCP2SCP
 config SIMPLE_PM_BUS
 	bool "Simple Power-Managed Bus Driver"
 	depends on OF && PM
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  Driver for transparent busses that don't need a real driver, but
 	  where the bus controller is part of a PM domain, or under the control
-- 
2.1.4
