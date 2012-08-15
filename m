From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Aug 2012 11:26:30 -0300
Subject: [PATCH v2 1/2] ARM: mach-imx: Remove board entries in dt_board_compat
Message-ID: <1345040791-3000-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need for adding board related entries into dt_board_compat.

Leave only the SoC entry.

This way we do not need to patch a C file when adding dt support for a new board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
--
Changes since v1:
- Rebased against 3.6-rc
---
 arch/arm/mach-imx/imx51-dt.c   |    1 -
 arch/arm/mach-imx/imx53-dt.c   |    4 ----
 arch/arm/mach-imx/mach-imx6q.c |    3 ---
 3 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index d4067fe..8604165 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -79,7 +79,6 @@ static struct sys_timer imx51_timer = {
 };
 
 static const char *imx51_dt_board_compat[] __initdata = {
-	"fsl,imx51-babbage",
 	"fsl,imx51",
 	NULL
 };
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 1b7a2fc..d193d8f 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -105,10 +105,6 @@ static struct sys_timer imx53_timer = {
 };
 
 static const char *imx53_dt_board_compat[] __initdata = {
-	"fsl,imx53-ard",
-	"fsl,imx53-evk",
-	"fsl,imx53-qsb",
-	"fsl,imx53-smd",
 	"fsl,imx53",
 	NULL
 };
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5ec0608..7a9599f 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -218,9 +218,6 @@ static struct sys_timer imx6q_timer = {
 };
 
 static const char *imx6q_dt_compat[] __initdata = {
-	"fsl,imx6q-arm2",
-	"fsl,imx6q-sabrelite",
-	"fsl,imx6q-sabresd",
 	"fsl,imx6q",
 	NULL,
 };
-- 
1.7.9.5
