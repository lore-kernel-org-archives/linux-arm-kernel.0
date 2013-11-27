From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 02:18:32 +0100
Subject: [PATCH 10/15] irda: sh_irda: Enable driver compilation with
 COMPILE_TEST
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1385515117-23664-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps increasing build testing coverage.

Cc: Samuel Ortiz <samuel@sortiz.org>
Cc: netdev at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/net/irda/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 2a30193..cae5ee2 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -403,7 +403,8 @@ config MCS_FIR
 
 config SH_IRDA
 	tristate "SuperH IrDA driver"
-	depends on IRDA && ARCH_SHMOBILE
+	depends on IRDA
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Say Y here if your want to enable SuperH IrDA devices.
 
-- 
1.8.3.2
