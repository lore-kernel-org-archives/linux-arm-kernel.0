From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 9 Aug 2011 21:41:45 +0200
Subject: [PATCH 4/5] mach-u300: delete bogus memory mappings
Message-ID: <1312918905-11927-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Get rid of the bogus memory map to TCM (there is a real
mechanism for handling that nowadays!) and the commented-
out declaration of the ROM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 8b78af9..ba0b1d3 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -68,25 +68,6 @@ static struct map_desc u300_io_desc[] __initdata = {
 		.length		= SZ_32K,
 		.type		= MT_DEVICE,
 	},
-	{
-		.virtual	= 0xffff2000, /* TCM memory */
-		.pfn		= __phys_to_pfn(0xffff2000),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	},
-
-	/*
-	 * This overlaps with the IRQ vectors etc at 0xffff0000, so these
-	 * may have to be moved to 0x00000000 in order to use the ROM.
-	 */
-	/*
-	{
-		.virtual	= U300_BOOTROM_VIRT_BASE,
-		.pfn		= __phys_to_pfn(U300_BOOTROM_PHYS_BASE),
-		.length		= SZ_64K,
-		.type		= MT_ROM,
-	},
-	*/
 };
 
 void __init u300_map_io(void)
-- 
1.7.3.2
