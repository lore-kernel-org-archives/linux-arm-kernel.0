From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 22 Dec 2010 12:46:07 -0500
Subject: [PATCH] davinci: Add additional JTAG code for AM-1808 and OMAP-L138
	Rev 2.0 SoCs
Message-ID: <1293039967-20165-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
In addition, the variant code for the AM-1808 SoC appears to match
the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
these chips.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
There are two whitespace fix-ups that were needed to pass checkpatch.pl

 arch/arm/mach-davinci/da850.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 78b5ae2..3f888b3 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -764,6 +764,13 @@ static struct davinci_id da850_ids[] = {
 		.cpu_id		= DAVINCI_CPU_ID_DA850,
 		.name		= "da850/omap-l138",
 	},
+	{
+		.variant	= 0x1,
+		.part_no	= 0xb7d1,
+		.manufacturer	= 0x017,	/* 0x02f >> 1 */
+		.cpu_id		= DAVINCI_CPU_ID_DA850,
+		.name		= "da850/omap-l138/am18xx",
+	},
 };
 
 static struct davinci_timer_instance da850_timer_instance[4] = {
@@ -814,7 +821,7 @@ static void da850_set_async3_src(int pllnum)
 			WARN(ret, "DA850: unable to re-parent clock %s",
 								clk->name);
 		}
-       }
+	}
 
 	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 	if (pllnum)
@@ -895,7 +902,7 @@ static const struct da850_opp da850_opp_96 = {
 	.cvdd_max	= 1050000,
 };
 
-#define OPP(freq) 		\
+#define OPP(freq)	\
 	{				\
 		.index = (unsigned int) &da850_opp_##freq,	\
 		.frequency = freq * 1000, \
-- 
1.7.0.4
