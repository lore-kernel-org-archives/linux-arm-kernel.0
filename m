From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:28 +0400
Subject: [PATCH 02/15] ARM: pxa/mioa701: drop udc_is_connected
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mioa701 is a pxa270 machine and pxa27x_udc driver doesn't pay any attention
to udc_is_connected, so drop it.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index e347013..d833a26 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -402,13 +402,7 @@ static void gsm_exit(void)
 /*
  * USB UDC
  */
-static int is_usb_connected(void)
-{
-	return !gpio_get_value(GPIO13_nUSB_DETECT);
-}
-
 static struct pxa2xx_udc_mach_info mioa701_udc_info = {
-	.udc_is_connected = is_usb_connected,
 	.gpio_pullup	  = GPIO22_USB_ENABLE,
 };
 
@@ -569,6 +563,11 @@ static int is_ac_connected(void)
 	return gpio_get_value(GPIO96_AC_DETECT);
 }
 
+static int is_usb_connected(void)
+{
+	return !gpio_get_value(GPIO13_nUSB_DETECT);
+}
+
 static void mioa701_set_charge(int flags)
 {
 	gpio_set_value(GPIO9_CHARGE_EN, (flags == PDA_POWER_CHARGE_USB));
-- 
1.7.5.4
