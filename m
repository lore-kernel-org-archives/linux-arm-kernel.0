From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Wed, 25 Jun 2014 14:28:30 +0200
Subject: [PATCH] arch: arm: mach-omap2: usb-tusb6010.c: Cleaning up variable
 is set more than once
Message-ID: <1403699310-22960-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A struct member variable is set to the same value more than once

This was found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index e832bc7..8333400 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -95,7 +95,6 @@ static int tusb_set_sync_mode(unsigned sysclk_ps)
 	dev_t.t_avdp_w = t_scsnh_advnh;
 	dev_t.cyc_aavdh_we = 3;
 	dev_t.cyc_wpl = 6;
-	dev_t.t_ce_rdyz = 7000;
 
 	gpmc_calc_timings(&t, &tusb_sync, &dev_t);
 
-- 
1.7.10.4
