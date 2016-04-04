From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:31 +0900
Subject: [PATCH] bus: simple-pm-bus: Use ARCH_RENESAS
In-Reply-To: <cover.1459732818.git.horms+renesas@verge.net.au>
References: <cover.1459732818.git.horms+renesas@verge.net.au>
Message-ID: <41feae79f2621d9fcea1437d4a2f29dc731fdbb0.1459732818.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d4a3a3133da5..67cebd3d7f2d 100644
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
