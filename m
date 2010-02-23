From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 22 Feb 2010 21:50:40 -0700
Subject: [PATCH 01/11] OMAP3: clock: add capability to change rate of
	dpll4_m5_ck_3630
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Message-ID: <20100223045012.18888.4512.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>

Add necessary clk_sel definitions to clock framework to allow changing
dpll4_m5_ck_3630 rate. This is used by the ISP driver.

Signed-off-by: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>
[paul at pwsan.com: updated to apply]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index fd83230..d5153b6 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -927,6 +927,8 @@ static struct clk dpll4_m5_ck_3630 __initdata = {
 	.clksel_mask	= OMAP3630_CLKSEL_CAM_MASK,
 	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
 	.recalc		= &omap2_clksel_recalc,
 };
 
