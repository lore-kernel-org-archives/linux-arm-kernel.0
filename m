From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:22 -0700
Subject: [PATCH 08/28] omap3: Fix EHCI port for IGEP v2 board
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231122.31953.75675.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

IGEP v2 uses EHCI port 1 instead of EHCI port 2.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3c7789d..d55c57b 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -458,13 +458,13 @@ static struct omap_musb_board_data musb_board_data = {
 };
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset = true,
-	.reset_gpio_port[0] = -EINVAL,
-	.reset_gpio_port[1] = IGEP2_GPIO_USBH_NRESET,
+	.reset_gpio_port[0] = IGEP2_GPIO_USBH_NRESET,
+	.reset_gpio_port[1] = -EINVAL,
 	.reset_gpio_port[2] = -EINVAL,
 };
 
