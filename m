From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jan 2010 16:20:32 -0800
Subject: [PATCH 10/12] omap3: add missing parentheses
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Message-ID: <20100107002032.21352.77140.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roel Kluin <roel.kluin@gmail.com>

`!' has a higher precedence than `&' so parentheses are required.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 81ed252..c6cc809 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -124,8 +124,8 @@ static void omap3_core_save_context(void)
 	control_padconf_off |= START_PADCONF_SAVE;
 	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
 	/* wait for the save to complete */
-	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
-			& PADCONF_SAVE_DONE)
+	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
+			& PADCONF_SAVE_DONE))
 		;
 	/* Save the Interrupt controller context */
 	omap_intc_save_context();
