From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Dec 2009 21:20:21 -0700
Subject: [PATCH 6/8] OMAP3 clock: McBSP 2, 3,
	4 functional clock parent is PER_96M_FCLK, not CORE_96M_FCLK
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Message-ID: <20091218042020.27280.77746.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct parent of the McBSP 2, 3, and 4 functional clocks is
PER_96M_FCLK, not CORE_96M_FCLK.  Fix this in the OMAP clock tree.
Reported by Nicole Chalhoub <n-chalhoub@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Nicole Chalhoub <n-chalhoub@ti.com>
---
 arch/arm/mach-omap2/clock34xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index c60b19a..7eea9fb 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -2747,7 +2747,7 @@ static struct clk mcbsp4_ick = {
 };
 
 static const struct clksel mcbsp_234_clksel[] = {
-	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
+	{ .parent = &per_96m_fck,  .rates = common_mcbsp_96m_rates },
 	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
 	{ .parent = NULL }
 };
