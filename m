From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 13 Jul 2012 17:19:42 +0300
Subject: [PATCHv4 5/8] ARM: OMAP3: set autoidle flag for sdrc_ick
In-Reply-To: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
Message-ID: <1342189185-5306-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdrc_ick doesn't have autoidle flag on HW, but is always automatically
idled. Thus mark the autoidle flag statically as true for it to reflect
hardware behavior. The clock will no longer show as active in usecount
dumps and will allow the voltdm->sleep / wakeup calls to work properly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1efdec2..596e041 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1751,6 +1751,7 @@ static struct clk sdrc_ick = {
 	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
+	.autoidle	= true,
 };
 
 static struct clk gpmc_fck = {
-- 
1.7.4.1
