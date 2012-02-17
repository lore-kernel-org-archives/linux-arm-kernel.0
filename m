From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 17 Feb 2012 12:07:00 +0100
Subject: [PATCH] ARM i.MX5/6: Add dt support for generic boards
Message-ID: <1329476820-27066-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from the iomux setup which may not be needed on custom
boards the kernel starts fine using the devicetree, so add
generic boards to the dt_compat entries.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/imx51-dt.c   |    1 +
 arch/arm/mach-imx/imx53-dt.c   |    1 +
 arch/arm/mach-imx/mach-imx6q.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index e6bad17..b0d830f 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -104,6 +104,7 @@ static struct sys_timer imx51_timer = {
 
 static const char *imx51_dt_board_compat[] __initdata = {
 	"fsl,imx51-babbage",
+	"fsl,imx51",
 	NULL
 };
 
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 05ebb3e..d75a267 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -114,6 +114,7 @@ static const char *imx53_dt_board_compat[] __initdata = {
 	"fsl,imx53-evk",
 	"fsl,imx53-qsb",
 	"fsl,imx53-smd",
+	"fsl,imx53",
 	NULL
 };
 
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index c257281..f3adf2f 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -128,6 +128,7 @@ static struct sys_timer imx6q_timer = {
 static const char *imx6q_dt_compat[] __initdata = {
 	"fsl,imx6q-arm2",
 	"fsl,imx6q-sabrelite",
+	"fsl,imx6q",
 	NULL,
 };
 
-- 
1.7.9
