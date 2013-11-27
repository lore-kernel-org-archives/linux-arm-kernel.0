From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 02:18:34 +0100
Subject: [PATCH 12/15] thermal: rcar-thermal: Enable driver compilation with
 COMPILE_TEST
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1385515117-23664-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps increasing build testing coverage.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f35a1f7..661cafc 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -121,7 +121,7 @@ config SPEAR_THERMAL
 
 config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
-	depends on ARCH_SHMOBILE
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
 	  thermal framework.
-- 
1.8.3.2
