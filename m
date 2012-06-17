From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 17 Jun 2012 11:04:15 -0300
Subject: [PATCH 1/2] ARM: mach-imx: Remove board entries in dt_board_compat
Message-ID: <1339941856-2836-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need for adding board related entries into dt_board_compat.

Leave only the SoC entry.

This way we do not need to patch a C file when adding dt support for a new board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/imx51-dt.c   |    1 -
 arch/arm/mach-imx/imx53-dt.c   |    4 ----
 arch/arm/mach-imx/mach-imx6q.c |    3 ---
 3 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 18e78db..5f10812 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -106,7 +106,6 @@ static struct sys_timer imx51_timer = {
 };
 
 static const char *imx51_dt_board_compat[] __initdata = {
-	"fsl,imx51-babbage",
 	"fsl,imx51",
 	NULL
 };
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index eb04b62..75535f9 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -132,10 +132,6 @@ static struct sys_timer imx53_timer = {
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
index b47e98b..1796be4 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -173,9 +173,6 @@ static struct sys_timer imx6q_timer = {
 };
 
 static const char *imx6q_dt_compat[] __initdata = {
-	"fsl,imx6q-arm2",
-	"fsl,imx6q-sabrelite",
-	"fsl,imx6q-sabresd",
 	"fsl,imx6q",
 	NULL,
 };
-- 
1.7.1
