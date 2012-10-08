From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 8 Oct 2012 01:42:59 +0000 (UTC)
Subject: ARM: OMAP: fix new sparse warnings
In-Reply-To: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1210080141040.5736@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here's an updated version of this one that drops the debug-devices.c 
change.   That will be dealt with in a separate patch.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 7 Oct 2012 13:10:00 -0600
Subject: [PATCH] ARM: OMAP: omap3evm: fix new sparse warning

Commit e54adb1e79762d3591459e5b0e9b9ff578e33fdb ("ARM: OMAP: omap3evm:
cleanup revision bits") adds a new sparse[1] warning:

arch/arm/mach-omap2/board-omap3evm.c:90:4: warning: symbol 'get_omap3_evm_rev' was not declared. Should it be static?

This symbol no longer appears to be used outside this file, so mark it
static and remove the export.

...

1. https://sparse.wiki.kernel.org/index.php/Main_Page

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c64e565..184ef21 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -88,11 +88,10 @@ enum {
 
 static u8 omap3_evm_version;
 
-u8 get_omap3_evm_rev(void)
+static u8 get_omap3_evm_rev(void)
 {
 	return omap3_evm_version;
 }
-EXPORT_SYMBOL(get_omap3_evm_rev);
 
 static void __init omap3_evm_get_revision(void)
 {
-- 
1.7.10.4
