From: srinath@mistralsolutions.com (srinath at mistralsolutions.com)
Date: Fri, 29 Apr 2011 17:11:00 +0530
Subject: [PATCH 1/2] AM35xx-Craneboard: USB EHCI: Fix USB ECHI PHY reset
In-Reply-To: <[PATCH]>
References: <[PATCH]>
Message-ID: <1304077261-17811-1-git-send-email-srinath@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinath <srinath@mistralsolutions.com>

This patch fixes the EHCI PHY reset issue found on CraneBoard.

Signed-off-by: Srinath <srinath@mistralsolutions.com>
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
1.7.1.226.g770c5
