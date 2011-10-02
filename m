From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 16:45:51 +0200
Subject: [PATCH 21/30] sound/soc/omap: limit to omap2plus
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Message-ID: <1317566760-25681-22-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These drivers do not build correctly on omap1, so only allow
selecting them on omap2 or higher.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 sound/soc/omap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index fe83d0d..493733e 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,6 +1,6 @@
 config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP2PLUS
 
 config SND_OMAP_SOC_MCBSP
 	tristate
-- 
1.7.5.4
