From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:15 +0100
Subject: [PATCH 02/10] ARM: realview: don't map undefined PCI registers
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI support for realview was never merged, and trying to build realview with
CONFIG_PCI enabled fails because the constants for the mapping windows are
not defined anywhere.

This removes them from the static I/O window mapping table as a preparation
for multiplatform support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/realview_pba8.c | 8 --------
 arch/arm/mach-realview/realview_pbx.c  | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 4c64662f5437..b3549a637ff0 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -77,14 +77,6 @@ static struct map_desc realview_pba8_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	},
-#ifdef CONFIG_PCI
-	{
-		.virtual	= PCIX_UNIT_BASE,
-		.pfn		= __phys_to_pfn(REALVIEW_PBA8_PCI_BASE),
-		.length		= REALVIEW_PBA8_PCI_BASE_SIZE,
-		.type		= MT_DEVICE
-	},
-#endif
 #ifdef CONFIG_DEBUG_LL
 	{
 		.virtual	= IO_ADDRESS(REALVIEW_PBA8_UART0_BASE),
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 9a22b864219f..f26e1e09f29e 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -79,14 +79,6 @@ static struct map_desc realview_pbx_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	},
-#ifdef CONFIG_PCI
-	{
-		.virtual	= PCIX_UNIT_BASE,
-		.pfn		= __phys_to_pfn(REALVIEW_PBX_PCI_BASE),
-		.length		= REALVIEW_PBX_PCI_BASE_SIZE,
-		.type		= MT_DEVICE,
-	},
-#endif
 #ifdef CONFIG_DEBUG_LL
 	{
 		.virtual	= IO_ADDRESS(REALVIEW_PBX_UART0_BASE),
-- 
2.1.0.rc2
