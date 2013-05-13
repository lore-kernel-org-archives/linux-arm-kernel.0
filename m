From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:30 +0400
Subject: [PATCH 08/15] ARM: clps711x: Move specific definitions from
 hardware.h to boards files
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-11-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-edb7211.c         | 8 ++++++--
 arch/arm/mach-clps711x/include/mach/hardware.h | 7 -------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index e1c5573..3ba4b9e 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -39,9 +39,13 @@
 
 #define EDB7211_FLASH0_BASE	(CS0_PHYS_BASE)
 #define EDB7211_FLASH1_BASE	(CS1_PHYS_BASE)
+
 #define EDB7211_CS8900_BASE	(CS2_PHYS_BASE + 0x300)
 #define EDB7211_CS8900_IRQ	(IRQ_EINT3)
 
+/* The extra 8 lines of the keyboard matrix */
+#define EDB7211_EXTKBD_BASE	(CS3_PHYS_BASE)
+
 static struct resource edb7211_cs8900_resource[] __initdata = {
 	DEFINE_RES_MEM(EDB7211_CS8900_BASE, SZ_1K),
 	DEFINE_RES_IRQ(EDB7211_CS8900_IRQ),
@@ -113,8 +117,8 @@ static struct gpio edb7211_gpios[] __initconst = {
 
 static struct map_desc edb7211_io_desc[] __initdata = {
 	{	/* Memory-mapped extra keyboard row */
-		.virtual	= IO_ADDRESS(EP7211_PHYS_EXTKBD),
-		.pfn		= __phys_to_pfn(EP7211_PHYS_EXTKBD),
+		.virtual	= IO_ADDRESS(EDB7211_EXTKBD_BASE),
+		.pfn		= __phys_to_pfn(EDB7211_EXTKBD_BASE),
 		.length		= SZ_1M,
 		.type		= MT_DEVICE,
 	},
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 2f23dd5..c5a8ea6 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -70,11 +70,4 @@
 #define CLPS711X_SDRAM0_BASE	(0xc0000000)
 #define CLPS711X_SDRAM1_BASE	(0xd0000000)
 
-#if defined (CONFIG_ARCH_EDB7211)
-
-/* The extra 8 lines of the keyboard matrix are wired to chip select 3 */
-#define EP7211_PHYS_EXTKBD	CS3_PHYS_BASE
-
-#endif /* CONFIG_ARCH_EDB7211 */
-
 #endif
-- 
1.8.1.5
