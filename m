From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 19:05:36 +0300
Subject: [PATCHv6 05/11] ARM: OMAP3: set autoidle flag for sdrc_ick
In-Reply-To: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Message-ID: <1348589142-11983-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdrc_ick doesn't have autoidle flag on HW, but is always automatically
idled. Thus mark the autoidle flag statically as true for it to reflect
hardware behavior. The clock will no longer show as active in usecount
dumps and will allow the voltdm->sleep / wakeup calls to work properly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Reviewed-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 83bed9a..1ddc7fc 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1739,6 +1739,7 @@ static struct clk sdrc_ick = {
 	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
+	.autoidle	= true,
 };
 
 static struct clk gpmc_fck = {
-- 
1.7.4.1
