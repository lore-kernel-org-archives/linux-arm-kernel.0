From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Dec 2009 21:20:22 -0700
Subject: [PATCH 7/8] OMAP3 clock: Add capability to change rate of dpll4_m5_ck
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Message-ID: <20091218042021.27280.93551.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>

Add necessary definitions to clock framework to allow changing
dpll4_m5_ck rate.  This is used by the camera code.

Signed-off-by: Jouni H?gander <jouni.hogander@nokia.com>
Signed-off-by: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 7eea9fb..c6031d7 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -776,6 +776,8 @@ static struct clk dpll4_m5_ck = {
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
 	.clksel		= div16_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
 	.recalc		= &omap2_clksel_recalc,
 };
 
