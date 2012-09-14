From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:43 +0200
Subject: [PATCH 15/24] ARM: sa1100: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Jochen Friedrich <jochen@scram.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-sa1100/include/mach/simpad.h |    2 +-
 arch/arm/mach-sa1100/simpad.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/simpad.h b/arch/arm/mach-sa1100/include/mach/simpad.h
index cdea671..ac2ea76 100644
--- a/arch/arm/mach-sa1100/include/mach/simpad.h
+++ b/arch/arm/mach-sa1100/include/mach/simpad.h
@@ -87,7 +87,7 @@
 #define SIMPAD_CS3_PCMCIA_SHORT		(SIMPAD_CS3_GPIO_BASE + 22)
 #define SIMPAD_CS3_GPIO_23		(SIMPAD_CS3_GPIO_BASE + 23)
 
-#define CS3_BASE        0xf1000000
+#define CS3_BASE        IOMEM(0xf1000000)
 
 long simpad_get_cs3_ro(void);
 long simpad_get_cs3_shadow(void);
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index fbd5359..6ca92d0 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -124,7 +124,7 @@ static struct map_desc simpad_io_desc[] __initdata = {
 		.length		= 0x00800000,
 		.type		= MT_DEVICE
 	}, {	/* Simpad CS3 */
-		.virtual	= CS3_BASE,
+		.virtual	= (unsigned long)CS3_BASE,
 		.pfn		= __phys_to_pfn(SA1100_CS3_PHYS),
 		.length		= 0x00100000,
 		.type		= MT_DEVICE
-- 
1.7.10
