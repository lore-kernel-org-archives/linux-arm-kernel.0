From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 26 Apr 2010 01:04:27 -0600
Subject: [PATCH 05/10] OMAP3: PM: PM_MPUGRPSEL writes should use GRPSEL macros,
	not EN macros
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Message-ID: <20100426070425.9743.93097.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writes to the PM_*GRPSEL registers should use _GRPSEL_ macros, not _EN_ macros,
to match the TRM and guard against inadvertent error.  This patch should
not cause any functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jouni H?gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e46a5e2..f2d3145 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -885,8 +885,9 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
 			  WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
-	prm_write_mod_reg(OMAP3430_EN_GPIO1_MASK | OMAP3430_EN_GPT1_MASK |
-			  OMAP3430_EN_GPT12_MASK,
+	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
+			  OMAP3430_GRPSEL_GPT1_MASK |
+			  OMAP3430_GRPSEL_GPT12_MASK,
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	/* For some reason IO doesn't generate wakeup event even if
 	 * it is selected to mpu wakeup goup */
@@ -905,11 +906,15 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_EN_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
-			  OMAP3430_GRPSEL_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
-			  OMAP3430_GRPSEL_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
-			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
-			  OMAP3430_EN_MCBSP4_MASK,
+	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK |
+			  OMAP3430_GRPSEL_GPIO3_MASK |
+			  OMAP3430_GRPSEL_GPIO4_MASK |
+			  OMAP3430_GRPSEL_GPIO5_MASK |
+			  OMAP3430_GRPSEL_GPIO6_MASK |
+			  OMAP3430_GRPSEL_UART3_MASK |
+			  OMAP3430_GRPSEL_MCBSP2_MASK |
+			  OMAP3430_GRPSEL_MCBSP3_MASK |
+			  OMAP3430_GRPSEL_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
