From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Nov 2011 12:05:58 -0800
Subject: [PATCH] ARM: OMAP: Fix dpll_data compile error when omap2 only is
 selected
Message-ID: <20111110200558.GV31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch we get the following error:

arch/arm/mach-omap2/clkt_dpll.c: In function '_dpll_test_fint':
arch/arm/mach-omap2/clkt_dpll.c:98: error: 'struct dpll_data' has no member named 'flags'

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 197ca03..eb73ab4 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -165,8 +165,8 @@ struct dpll_data {
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-	u8			flags;
 #  endif
+	u8			flags;
 };
 
 #endif
