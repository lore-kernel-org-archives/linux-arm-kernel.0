From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Jan 2012 17:24:30 -0200
Subject: [PATCH] ARM: imx: Fix build error due to redefinition of
 'mx50_io_desc'
Message-ID: <1326223470-30116-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build error:

CC      arch/arm/mach-imx/mm-imx5.o
arch/arm/mach-imx/mm-imx5.c:57: error: redefinition of 'mx50_io_desc'
arch/arm/mach-imx/mm-imx5.c:47: note: previous definition of 'mx50_io_desc' was here

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This applies against linux-next

 arch/arm/mach-imx/mm-imx5.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 2f04f8a..16671b7 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -52,16 +52,6 @@ static struct map_desc mx50_io_desc[] __initdata = {
 };
 
 /*
- * Define the MX50 memory map.
- */
-static struct map_desc mx50_io_desc[] __initdata = {
-	imx_map_entry(MX50, TZIC, MT_DEVICE),
-	imx_map_entry(MX50, SPBA0, MT_DEVICE),
-	imx_map_entry(MX50, AIPS1, MT_DEVICE),
-	imx_map_entry(MX50, AIPS2, MT_DEVICE),
-};
-
-/*
  * Define the MX51 memory map.
  */
 static struct map_desc mx51_io_desc[] __initdata = {
-- 
1.7.1
