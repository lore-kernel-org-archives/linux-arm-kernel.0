From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed,  2 Feb 2011 20:00:03 +0300
Subject: [PATCH 6/6] pxa2xx: drop gpio_vbus field from info struct
In-Reply-To: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
References: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1296666003-31647-7-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neither pxa25x_udc, nor pxa27x_udc use gpio_vbus/gpio_vbus_inverted
anymore. Drop those two fields from udc info completely.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/include/asm/mach/udc_pxa2xx.h |    2 --
 arch/arm/mach-pxa/corgi.c              |    1 -
 arch/arm/mach-pxa/devices.c            |    1 -
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/asm/mach/udc_pxa2xx.h
index 833306e..ea297ac 100644
--- a/arch/arm/include/asm/mach/udc_pxa2xx.h
+++ b/arch/arm/include/asm/mach/udc_pxa2xx.h
@@ -20,8 +20,6 @@ struct pxa2xx_udc_mach_info {
 	 * VBUS IRQ and omit the methods above.  Store the GPIO number
 	 * here.  Note that sometimes the signals go through inverters...
 	 */
-	bool	gpio_vbus_inverted;
-	int	gpio_vbus;			/* high == vbus present */
 	bool	gpio_pullup_inverted;
 	int	gpio_pullup;			/* high == pullup activated */
 };
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 821229ac..3d7a752 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -462,7 +462,6 @@ static struct pxaficp_platform_data corgi_ficp_platform_data = {
  * USB Device Controller
  */
 static struct pxa2xx_udc_mach_info udc_info __initdata = {
-	.gpio_vbus		= -1,
 	/* no connect GPIO; corgi can't tell connection status */
 	.gpio_pullup		= CORGI_GPIO_USB_PULLUP,
 };
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index aaa1166..cc8a6a5 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -90,7 +90,6 @@ void __init pxa_set_mci_info(struct pxamci_platform_data *info)
 
 static struct pxa2xx_udc_mach_info pxa_udc_info = {
 	.gpio_pullup = -1,
-	.gpio_vbus   = -1,
 };
 
 void __init pxa_set_udc_info(struct pxa2xx_udc_mach_info *info)
-- 
1.7.2.3
