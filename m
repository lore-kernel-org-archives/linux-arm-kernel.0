From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Dec 2010 15:00:17 -0800
Subject: [PATCH] msm: qsd8x50: Platform data isn't init data
Message-ID: <1292886017-23511-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the SMC91x platform and resource data from initdata.  These
will continue to be accessed after init, and must remain available.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/board-qsd8x50.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 5a557f3..c295f8a 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -45,7 +45,7 @@ static const unsigned        qsd8x50_surf_smc91x_gpio __initdata = 156;
  * at run-time: they vary from board to board, and the true
  * configuration won't be known until boot.
  */
-static struct resource smc91x_resources[] __initdata = {
+static struct resource smc91x_resources[] = {
 	[0] = {
 		.flags = IORESOURCE_MEM,
 	},
@@ -54,7 +54,7 @@ static struct resource smc91x_resources[] __initdata = {
 	},
 };
 
-static struct platform_device smc91x_device __initdata = {
+static struct platform_device smc91x_device = {
 	.name           = "smc91x",
 	.id             = 0,
 	.num_resources  = ARRAY_SIZE(smc91x_resources),
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
