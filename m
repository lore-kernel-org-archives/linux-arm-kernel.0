From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 13 Jan 2010 21:55:36 +0800
Subject: [PATCH 1/3] [ARM] pxa/corgi: fix incorrect default GPIO for UDC Vbus
Message-ID: <1263390938-3354-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no such GPIO for udc vbus sensing, put '-1' instead of default
'0' as '0' does mean a valid GPIO.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/corgi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 74446cf..da3156d 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -457,6 +457,7 @@ static struct pxaficp_platform_data corgi_ficp_platform_data = {
  * USB Device Controller
  */
 static struct pxa2xx_udc_mach_info udc_info __initdata = {
+	.gpio_vbus		= -1,
 	/* no connect GPIO; corgi can't tell connection status */
 	.gpio_pullup		= CORGI_GPIO_USB_PULLUP,
 };
-- 
1.6.3.3
