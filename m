From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:08 +0100
Subject: [PATCH 11/62] ARM: ep93xx: export ep93xx_chip_revision
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep93xx_chip_revision is used by the pata_ep93xx driver,
which can be a loadable module. Exporting the symbol
avoids a link error in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 6c70547..0e571f1 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -242,6 +242,7 @@ unsigned int ep93xx_chip_revision(void)
 	v >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
 	return v;
 }
+EXPORT_SYMBOL_GPL(ep93xx_chip_revision);
 
 /*************************************************************************
  * EP93xx GPIO
-- 
1.8.3.2
