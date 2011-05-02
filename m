From: srinath@mistralsolutions.com (srinath at mistralsolutions.com)
Date: Mon,  2 May 2011 19:10:42 +0530
Subject: [Patch v2] AM35xx-Craneboard: USB EHCI: Fix USB ECHI PHY reset
In-Reply-To: <[PATCH]>
References: <[PATCH]>
Message-ID: <1304343643-3148-1-git-send-email-srinath@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinath.R <srinath@mistralsolutions.com>

This patch fixes the EHCI PHY reset issue found on CraneBoard.

History:
https://patchwork.kernel.org/patch/740741/

Signed-off-by: Srinath.R <srinath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index a890d24..05867b5 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -60,7 +60,7 @@ static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
-	.phy_reset  = true,
+	.phy_reset  = false,
 	.reset_gpio_port[0]  = GPIO_USB_NRESET,
 	.reset_gpio_port[1]  = -EINVAL,
 	.reset_gpio_port[2]  = -EINVAL
-- 
1.5.3.4
