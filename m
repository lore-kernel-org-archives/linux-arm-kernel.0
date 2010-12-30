From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu, 30 Dec 2010 09:42:46 -0500
Subject: [PATCH v4] davinci: Add additional JTAG code for AM-1808 and
	OMAP-L138 Rev 2.0 SoCs
Message-ID: <1293720166-27261-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
In addition, the variant code for the AM-1808 SoC appears to match
the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
these chips.

This patch is originally from a patch on the arago project, here:
http://arago-project.org/git/projects/?p=linux-omapl1.git;a=commit;h=6157618435e313a444cdf059702bd34036a6e2b7

Further information related to the need for this patch can be located at
http://e2e.ti.com/support/embedded/f/354/p/67290/248486.aspx
http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-November/021224.html

This patch was tested using an AM-1808 SoC on a MityARM-1808 SoM card.  It
was also tested using a Rev 1.0 silicon OMAP-L138 on a MityDSP-L138F card.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Tested-by: Michael Williamson <michael.williamson@criticallink.com>
Reported-by: Nicolas Luna <luna.id@gmail.com>
---
Built against commit b411b51a71cd9c926712b33ab21d001ed7e57838 off Kevin's
davinci-linux tree.

Changes since v3:
 - change am18xx to am18x
 - add am18x tag to 0 variant per comments.

 arch/arm/mach-davinci/da850.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 78b5ae2..e489f67 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -762,7 +762,14 @@ static struct davinci_id da850_ids[] = {
 		.part_no	= 0xb7d1,
 		.manufacturer	= 0x017,	/* 0x02f >> 1 */
 		.cpu_id		= DAVINCI_CPU_ID_DA850,
-		.name		= "da850/omap-l138",
+		.name		= "da850/omap-l138/am18x",
+	},
+	{
+		.variant	= 0x1,
+		.part_no	= 0xb7d1,
+		.manufacturer	= 0x017,	/* 0x02f >> 1 */
+		.cpu_id		= DAVINCI_CPU_ID_DA850,
+		.name		= "da850/omap-l138/am18x",
 	},
 };
 
-- 
1.7.0.4
