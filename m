From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 15:01:10 +0200
Subject: [PATCH] clk: meson: fix CLKID_GCLK_VENCI_INT typo
Message-ID: <20160906130130.1645496-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The addition of many gate clocks added two entries in an array for
the same value:

drivers/clk/meson/meson8b.c:479:10: error: initialized field overwritten [-Werror=override-init]
   [CLKID_GCLK_VENCI_INT]     = &meson8b_gclk_venci_int.hw,
   [CLKID_GCLK_VENCI_INT]     = &meson8b_gclk_vencp_int.hw,

This was clearly an accident, and since all other identifiers are
listed in the order in which they are defined, I'm changing the
first one to CLKID_GCLK_VENCI_INT0, making it all consistent again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e31a1900c1ff ("meson: clk: Add support for clock gates")
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index e1d4aa145a03..0d45ec20c737 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -476,7 +476,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_VCLK2_VENCP0]	    = &meson8b_vclk2_vencp0.hw,
 		[CLKID_VCLK2_VENCP1]	    = &meson8b_vclk2_vencp1.hw,
 		[CLKID_GCLK_VENCI_INT]	    = &meson8b_gclk_venci_int.hw,
-		[CLKID_GCLK_VENCI_INT]	    = &meson8b_gclk_vencp_int.hw,
+		[CLKID_GCLK_VENCP_INT]	    = &meson8b_gclk_vencp_int.hw,
 		[CLKID_DAC_CLK]		    = &meson8b_dac_clk.hw,
 		[CLKID_AOCLK_GATE]	    = &meson8b_aoclk_gate.hw,
 		[CLKID_IEC958_GATE]	    = &meson8b_iec958_gate.hw,
-- 
2.9.0
