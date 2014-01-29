From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 Jan 2014 08:10:09 +0900
Subject: [PATCH 01/03] ARM: shmobile: Remove Lager USBHS UDC ifdefs
In-Reply-To: <20140129230959.22655.55645.sendpatchset@w520>
References: <20140129230959.22655.55645.sendpatchset@w520>
Message-ID: <20140129231009.22655.45084.sendpatchset@w520>
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
---

 arch/arm/mach-shmobile/board-lager.c |    4 ----
 1 file changed, 4 deletions(-)

--- 0003/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2014-01-24 10:16:15.000000000 +0900
@@ -368,7 +368,6 @@ static const struct platform_device_info
 };
 
 /* USBHS */
-#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
 static const struct resource usbhs_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6590000, 0x100),
 	DEFINE_RES_IRQ(gic_spi(107)),
@@ -478,9 +477,6 @@ static void __init lager_register_usbhs(
 					  &usbhs_priv.info,
 					  sizeof(usbhs_priv.info));
 }
-#else	/* CONFIG_USB_RENESAS_USBHS_UDC */
-static inline void lager_register_usbhs(void) { }
-#endif	/* CONFIG_USB_RENESAS_USBHS_UDC */
 
 /* USBHS PHY */
 static const struct rcar_gen2_phy_platform_data usbhs_phy_pdata __initconst = {
