From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:19:13 +0900
Subject: [PATCH 21/21] ARM: shmobile: Remove Lager USBHS UDC ifdefs
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <235cda29e4d5047622ff9b82b1f0b4cb6cf95f6c.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove ifdefs to make the Lager USBHS device always present.
This makes it more like other devices, no need to be special.

Also, these ifdefs by themselves do not hurt much, but combined
with USB Host device ifdefs that were proposed earlier we could
basically end up with a kernel that drives VBUS incorrectly
depending on the kernel configuration - lets not do that.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 4a95a45..fdcc868 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -368,7 +368,6 @@ static const struct platform_device_info sata1_info __initconst = {
 };
 
 /* USBHS */
-#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
 static const struct resource usbhs_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6590000, 0x100),
 	DEFINE_RES_IRQ(gic_spi(107)),
@@ -478,9 +477,6 @@ static void __init lager_register_usbhs(void)
 					  &usbhs_priv.info,
 					  sizeof(usbhs_priv.info));
 }
-#else	/* CONFIG_USB_RENESAS_USBHS_UDC */
-static inline void lager_register_usbhs(void) { }
-#endif	/* CONFIG_USB_RENESAS_USBHS_UDC */
 
 /* USBHS PHY */
 static const struct rcar_gen2_phy_platform_data usbhs_phy_pdata __initconst = {
-- 
1.8.5.2
