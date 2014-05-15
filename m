From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:23:51 +0200
Subject: [PATCH RFC 06/11] thermal: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Message-ID: <1400163836-9831-11-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm at vger.kernel.org
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d51912a6e40..14d15043b6f2 100644
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
2.0.0.rc2
