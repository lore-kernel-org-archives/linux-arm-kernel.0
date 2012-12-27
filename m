From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 27 Dec 2012 10:02:20 -0800
Subject: [PATCH v2 4/4] ARM: palmtreo: replace #if defined with IF_ENABLED
In-Reply-To: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
References: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356631340-30328-5-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use IF_ENABLED macro from kconfig.h.  Thanks Sergei.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/mach-pxa/palmtreo.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 8ca152b..d377369 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -167,7 +167,7 @@ static unsigned long centro685_pin_config[] __initdata = {
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
-#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
+#if IS_ENABLED(CONFIG_KEYBOARD_PXA27x)
 static unsigned int treo680_matrix_keys[] = {
 	KEY(0, 0, KEY_F8),		/* Red/Off/Power */
 	KEY(0, 1, KEY_LEFT),
@@ -315,7 +315,7 @@ static inline void palmtreo_kpc_init(void) {}
 /******************************************************************************
  * USB host
  ******************************************************************************/
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if IS_ENABLED(CONFIG_USB_OHCI_HCD)
 static struct pxaohci_platform_data treo680_ohci_info = {
 	.port_mode    = PMM_PERPORT_MODE,
 	.flags        = ENABLE_PORT1 | ENABLE_PORT3,
-- 
1.7.8.6
