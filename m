From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  2 Dec 2012 16:44:59 +0100
Subject: [PATCH] GPIO: MVEBU: Fix so only built when CONFIG_OF_IRQ
Message-ID: <1354463099-6121-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver only builds when CONFIG_OF_IRQ is enabled. So add this as
a dependency. Dockstar, and other none DT boards don't build because
of this, when all other OF boards are disabled.

Reported-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Willy Tarreau <w@1wt.eu>
---
 drivers/gpio/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 6dbc403..4d84c17 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -153,6 +153,7 @@ config GPIO_MSM_V2
 config GPIO_MVEBU
 	def_bool y
 	depends on PLAT_ORION
+	depends on OF_IRQ
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
-- 
1.7.10.4
