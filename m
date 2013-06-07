From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 17:22:09 +0900
Subject: [PATCH 11/11] ARM: shmobile: marzen: keep local function as static
In-Reply-To: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
References: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370593329-27559-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

marzen_init_late() should be static

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 71f174e..9b5ed7e 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -350,7 +350,7 @@ static struct platform_device *marzen_late_devices[] __initdata = {
 	&ohci1_device,
 };
 
-void __init marzen_init_late(void)
+static void __init marzen_init_late(void)
 {
 	/* get usb phy */
 	phy = usb_get_phy(USB_PHY_TYPE_USB2);
-- 
1.8.2.1
