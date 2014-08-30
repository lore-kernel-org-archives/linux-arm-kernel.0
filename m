From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 30 Aug 2014 18:46:08 +0200
Subject: [Patch v3] 3/7] thermal: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Message-ID: <1409417172-6846-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
Depend on MACH_KIRKWOOD, which will be set when kirkwood is built as
part of ARCH_MVEBU.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm at vger.kernel.org
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 693208eb9047..ef5587fe2c69 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -143,7 +143,7 @@ config RCAR_THERMAL
 
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
-	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD
 	depends on OF
 	help
 	  Support for the Kirkwood thermal sensor driver into the Linux thermal
-- 
2.1.0
