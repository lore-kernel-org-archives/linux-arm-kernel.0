From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:47 +0200
Subject: [PATCH 15/26] irda/ficp: only works on some pxa models
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver can only be built for pxa25x and pxa27x at the moment,
so encode that in Kconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Ortiz <samuel@sortiz.org>
---
 drivers/net/irda/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 25bb2a0..8cffd38 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -373,7 +373,7 @@ config VIA_FIR
 
 config PXA_FICP
 	tristate "Intel PXA2xx Internal FICP"
-	depends on ARCH_PXA && IRDA
+	depends on ARCH_PXA && IRDA && (PXA25x || PXA27x)
 	help
 	  Say Y or M here if you want to build support for the PXA2xx
 	  built-in IRDA interface which can support both SIR and FIR.
-- 
1.7.5.4
