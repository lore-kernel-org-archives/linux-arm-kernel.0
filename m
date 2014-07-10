From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jul 2014 23:36:30 +0200
Subject: [PATCH v2 10/12] phy: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Message-ID: <1405028192-9623-11-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
Depend on MACH_KIRKWOOD, which will be set when these SoCs are built
as part of mach-mvebv.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 16a2f067c242..d602b35e1779 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -27,7 +27,7 @@ config PHY_EXYNOS_MIPI_VIDEO
 
 config PHY_MVEBU_SATA
 	def_bool y
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
+	depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
 	depends on OF
 	select GENERIC_PHY
 
-- 
2.0.1
