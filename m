From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 9 Aug 2012 12:38:22 +0530
Subject: [PATCH v2 2/2] ARM: OMAP4: Register the OPP table only for 4430 device
In-Reply-To: <1344496102-24451-1-git-send-email-rnayak@ti.com>
References: <1344496102-24451-1-git-send-email-rnayak@ti.com>
Message-ID: <1344496102-24451-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 4430 OPP table was being registered for all other OMAP4 variants
too, like 4460 and 4470 causing issues with cpufreq driver
enabled. 4460 and 4470 devices have different OPPs as compared to
4430, and they should be populated seperately. As long as that
happens, let the OPP table registeration happen only on 4430 device.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/opp4xxx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..c95415d 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -94,7 +94,7 @@ int __init omap4_opp_init(void)
 {
 	int r = -ENODEV;
 
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap443x())
 		return r;
 
 	r = omap_init_opp_table(omap44xx_opp_def_list,
-- 
1.7.9.5
