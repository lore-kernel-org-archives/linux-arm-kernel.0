From: rnayak@ti.com (Rajendra Nayak)
Date: Tue,  8 Feb 2011 15:40:33 +0530
Subject: [PATCH 2/7] omap3: dpll: Populate clkops for dpll1_ck
In-Reply-To: <1297159838-30282-2-git-send-email-rnayak@ti.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
	<1297159838-30282-2-git-send-email-rnayak@ti.com>
Message-ID: <1297159838-30282-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DPLL1 on omap3 is very similar to the rest of
the non-core dpll's.
Hence populate clkops_omap3_noncore_dpll_ops
as the clkops for it, instead of the
currently populated clkops_null.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 403a4a1..3e9d721 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -296,7 +296,7 @@ static struct dpll_data dpll1_dd = {
 
 static struct clk dpll1_ck = {
 	.name		= "dpll1_ck",
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap3_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll1_dd,
 	.round_rate	= &omap2_dpll_round_rate,
-- 
1.7.0.4
