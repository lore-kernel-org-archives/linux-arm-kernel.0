From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jan 2010 18:05:43 -0700
Subject: [PATCH 09/10] OMAP powerdomain: remove pwrdm_clk_state_switch
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Message-ID: <20100112010542.6275.79480.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing calls pwrdm_clk_state_switch(), and the function that seems to be
its ideal use case calls pwrdm_clkdm_state_switch(clk->clkdm), so remove it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index df6446a..9d4b8f5 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -928,12 +928,6 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
 
 	return -EINVAL;
 }
-int pwrdm_clk_state_switch(struct clk *clk)
-{
-	if (clk != NULL && clk->clkdm != NULL)
-		return pwrdm_clkdm_state_switch(clk->clkdm);
-	return -EINVAL;
-}
 
 int pwrdm_pre_transition(void)
 {
