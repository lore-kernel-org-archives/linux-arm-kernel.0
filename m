From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:05:49 +0200
Subject: [PATCH 3/3] pcmcia: sa1100: H3100 and H3600 share a driver
In-Reply-To: <1402002349-1984057-1-git-send-email-arnd@arndb.de>
References: <1402002349-1984057-1-git-send-email-arnd@arndb.de>
Message-ID: <1402002349-1984057-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a iPAQ H3100-only kernel with PCMCIA enabled,
we get this build error:

ERROR: "pcmcia_h3600_init" [drivers/pcmcia/sa1100_cs.ko] undefined!

The defconfig normally works fine because it enables both H3100
and H3600 support. This patch fixes the Makefile to build the
driver if at least one of the two machines are selected.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pcmcia/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 7745b51..fd55a69 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -49,6 +49,7 @@ sa1100_cs-y					+= sa1100_generic.o
 sa1100_cs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
 sa1100_cs-$(CONFIG_SA1100_CERF)			+= sa1100_cerf.o
 sa1100_cs-$(CONFIG_SA1100_COLLIE)		+= pxa2xx_sharpsl.o
+sa1100_cs-$(CONFIG_SA1100_H3100)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_NANOENGINE)		+= sa1100_nanoengine.o
 sa1100_cs-$(CONFIG_SA1100_SHANNON)		+= sa1100_shannon.o
-- 
1.8.3.2
