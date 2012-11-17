From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:43 +0100
Subject: [PATCH v2 01/14] GPIO: mvebu: Allow all plat-orion platforms.
In-Reply-To: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
References: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353168058-14043-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kirkwood & Dove can also use this driver, so expand the scope to
include all platform orion devices.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/gpio/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f11d8e3..6dbc403 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -152,7 +152,7 @@ config GPIO_MSM_V2
 
 config GPIO_MVEBU
 	def_bool y
-	depends on ARCH_MVEBU
+	depends on PLAT_ORION
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
-- 
1.7.10.4
