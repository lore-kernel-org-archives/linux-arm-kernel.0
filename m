From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:32 +0200
Subject: [PATCH 04/24] ARM: ep93xx: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ep93xx/include/mach/ts72xx.h |   10 +++++-----
 arch/arm/mach-ep93xx/ts72xx.c              |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
index f1397a1..071feaa 100644
--- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
+++ b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
@@ -14,7 +14,7 @@
  */
 
 #define TS72XX_MODEL_PHYS_BASE		0x22000000
-#define TS72XX_MODEL_VIRT_BASE		0xfebff000
+#define TS72XX_MODEL_VIRT_BASE		IOMEM(0xfebff000)
 #define TS72XX_MODEL_SIZE		0x00001000
 
 #define TS72XX_MODEL_TS7200		0x00
@@ -26,7 +26,7 @@
 
 
 #define TS72XX_OPTIONS_PHYS_BASE	0x22400000
-#define TS72XX_OPTIONS_VIRT_BASE	0xfebfe000
+#define TS72XX_OPTIONS_VIRT_BASE	IOMEM(0xfebfe000)
 #define TS72XX_OPTIONS_SIZE		0x00001000
 
 #define TS72XX_OPTIONS_COM2_RS485	0x02
@@ -34,18 +34,18 @@
 
 
 #define TS72XX_OPTIONS2_PHYS_BASE	0x22800000
-#define TS72XX_OPTIONS2_VIRT_BASE	0xfebfd000
+#define TS72XX_OPTIONS2_VIRT_BASE	IOMEM(0xfebfd000)
 #define TS72XX_OPTIONS2_SIZE		0x00001000
 
 #define TS72XX_OPTIONS2_TS9420		0x04
 #define TS72XX_OPTIONS2_TS9420_BOOT	0x02
 
 
-#define TS72XX_RTC_INDEX_VIRT_BASE	0xfebf9000
+#define TS72XX_RTC_INDEX_VIRT_BASE	IOMEM(0xfebf9000)
 #define TS72XX_RTC_INDEX_PHYS_BASE	0x10800000
 #define TS72XX_RTC_INDEX_SIZE		0x00001000
 
-#define TS72XX_RTC_DATA_VIRT_BASE	0xfebf8000
+#define TS72XX_RTC_DATA_VIRT_BASE	IOMEM(0xfebf8000)
 #define TS72XX_RTC_DATA_PHYS_BASE	0x11700000
 #define TS72XX_RTC_DATA_SIZE		0x00001000
 
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 75cab2d..faa5bdd 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -32,27 +32,27 @@
 
 static struct map_desc ts72xx_io_desc[] __initdata = {
 	{
-		.virtual	= TS72XX_MODEL_VIRT_BASE,
+		.virtual	= (unsigned long)TS72XX_MODEL_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS72XX_MODEL_PHYS_BASE),
 		.length		= TS72XX_MODEL_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= TS72XX_OPTIONS_VIRT_BASE,
+		.virtual	= (unsigned long)TS72XX_OPTIONS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS72XX_OPTIONS_PHYS_BASE),
 		.length		= TS72XX_OPTIONS_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= TS72XX_OPTIONS2_VIRT_BASE,
+		.virtual	= (unsigned long)TS72XX_OPTIONS2_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS72XX_OPTIONS2_PHYS_BASE),
 		.length		= TS72XX_OPTIONS2_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= TS72XX_RTC_INDEX_VIRT_BASE,
+		.virtual	= (unsigned long)TS72XX_RTC_INDEX_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS72XX_RTC_INDEX_PHYS_BASE),
 		.length		= TS72XX_RTC_INDEX_SIZE,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= TS72XX_RTC_DATA_VIRT_BASE,
+		.virtual	= (unsigned long)TS72XX_RTC_DATA_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS72XX_RTC_DATA_PHYS_BASE),
 		.length		= TS72XX_RTC_DATA_SIZE,
 		.type		= MT_DEVICE,
-- 
1.7.10
