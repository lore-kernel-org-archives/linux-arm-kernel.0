From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:29 -0700
Subject: [PATCH 11/28] omap: Devkit8000: Fix wrong usb port on Devkit8000
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231129.31953.42867.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Weber <weber@corscience.de>

Disable the nonexistent ehci port on Devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..db4c093 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -639,12 +639,12 @@ static struct omap_musb_board_data musb_board_data = {
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = 147,
+	.reset_gpio_port[1]  = -EINVAL,
 	.reset_gpio_port[2]  = -EINVAL
 };
 
