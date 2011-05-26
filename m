From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Thu, 26 May 2011 16:08:10 +0530
Subject: [PATCH] OMAP: clockdomain: Remove redundant call to
	pwrdm_wait_transition()
Message-ID: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The call to pwrdm_wait_transition() in clkdm_clk_enable()
is redundant since the function pwrdm_clkdm_state_switch()
which is called next also does the same thing.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6cb6c03..4fbbbfc 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -834,7 +834,6 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 		 clk->name);
 
 	arch_clkdm->clkdm_clk_enable(clkdm);
-	pwrdm_wait_transition(clkdm->pwrdm.ptr);
 	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
-- 
1.6.2.4
