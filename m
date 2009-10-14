From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:20 +0200
Subject: [PATCH 03/10] [ARM] pxa/cm-x300: add ac97 controller registration
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <5293e22f72e02b62d172573df9c7f47fa410968a.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 05f1d56..c4b47d8 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -40,6 +40,7 @@
 #include <mach/ohci.h>
 #include <plat/i2c.h>
 #include <mach/pxa3xx_nand.h>
+#include <mach/audio.h>
 
 #include <asm/mach/map.h>
 
@@ -305,6 +306,15 @@ static void __init cm_x300_init_spi(void)
 static inline void cm_x300_init_spi(void) {}
 #endif
 
+#if defined(CONFIG_SND_PXA2XX_LIB_AC97)
+static void __init cm_x300_init_ac97(void)
+{
+	pxa_set_ac97_info(NULL);
+}
+#else
+static inline void cm_x300_init_ac97(void) {}
+#endif
+
 #if defined(CONFIG_MTD_NAND_PXA3xx) || defined(CONFIG_MTD_NAND_PXA3xx_MODULE)
 static struct mtd_partition cm_x300_nand_partitions[] = {
 	[0] = {
@@ -526,6 +536,7 @@ static void __init cm_x300_init(void)
 	cm_x300_init_i2c();
 	cm_x300_init_spi();
 	cm_x300_init_rtc();
+	cm_x300_init_ac97();
 }
 
 static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag *tags,
-- 
1.6.0.6
