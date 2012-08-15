From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Aug 2012 11:29:00 -0300
Subject: [PATCH v3 2/2] ARM: mach-mxs: Remove board entries in dt_board_compat
Message-ID: <1345040940-3045-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need for adding board related entries into dt_board_compat.

Leave only the SoC entry.

This way we do not need to patch a C file when adding dt support for a new board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
--
Changes since v2:
- Fix From field
Changes since v1:
- Rebased against 3.6-rc1
 arch/arm/mach-mxs/mach-mxs.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8dabfe8..fb453fd 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -286,19 +286,11 @@ static void __init mxs_machine_init(void)
 }
 
 static const char *imx23_dt_compat[] __initdata = {
-	"fsl,imx23-evk",
-	"fsl,stmp378x_devb"
-	"olimex,imx23-olinuxino",
 	"fsl,imx23",
 	NULL,
 };
 
 static const char *imx28_dt_compat[] __initdata = {
-	"bluegiga,apx4devkit",
-	"crystalfontz,cfa10036",
-	"denx,m28evk",
-	"fsl,imx28-evk",
-	"karo,tx28",
 	"fsl,imx28",
 	NULL,
 };
-- 
1.7.9.5
