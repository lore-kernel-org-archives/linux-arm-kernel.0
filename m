From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 13 Jan 2014 02:00:25 +0100
Subject: [patch] fix omap compile with randconfig
Message-ID: <20140113010025.GA14431@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This fixes:

arch/arm/mach-omap2/built-in.o: In function `omap_reserve':
/data/l/linux-n900/arch/arm/mach-omap2/common.c:36: undefined
  reference to `omap_fb_reserve_memblock'

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 9beecde..857907f 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -33,5 +33,7 @@ void __init omap_reserve(void)
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
+#ifdef CONFIG_OMAP2_VRFB
 	omap_fb_reserve_memblock();
+#endif
 }


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
