From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:18:18 +0900
Subject: [PATCH 12/12] ARM: shmobile: mackerel: Fix USBHS pinconf entry
In-Reply-To: <cover.1387891831.git.horms+renesas@verge.net.au>
References: <cover.1387891831.git.horms+renesas@verge.net.au>
Message-ID: <b58c8e7b43ad804ad18b30f882b16da2e3d4ed9d.1387891831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Fix a typo in the USBHS1 pinconf entry that prevented the pull-down from
being enabled.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 207acf0..b3ee96e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1406,7 +1406,7 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* USBHS1 */
 	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
 				  "usb1_vbus", "usb1"),
-	PIN_MAP_CONFIGS_GROUP_DEFAULT("renesas_usbhs.&", "pfc-sh7372",
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
 				      "usb1_vbus", pin_pulldown_conf),
 	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
 				  "usb1_otg_id_0", "usb1"),
-- 
1.8.4
