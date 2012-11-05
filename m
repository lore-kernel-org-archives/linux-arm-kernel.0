From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 5 Nov 2012 10:34:52 +0100
Subject: [PATCH 1/1 v2] usb: at91_udc: fix typo on vubs pullup valid check
Message-ID: <20121105093451.GA20063@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if the gpio is not valid complain

since 3285e0ec088febc5a88f57ddd78385a7da71476c
ARM: at91/udc: use gpio_is_valid to check the gpio

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-usb at vger.kernel.org
Cc: stable at vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
v2:

	update commit and put Felipe in Cc
Hi Greg,

	this is broken since 3.2 can we have on the stable too

Best Regards,
J.
 drivers/usb/gadget/at91_udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 89d90b5..888cb2a 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1739,7 +1739,7 @@ static int __devinit at91udc_probe(struct platform_device *pdev)
 
 	/* rm9200 needs manual D+ pullup; off by default */
 	if (cpu_is_at91rm9200()) {
-		if (gpio_is_valid(udc->board.pullup_pin)) {
+		if (!gpio_is_valid(udc->board.pullup_pin)) {
 			DBG("no D+ pullup?\n");
 			retval = -ENODEV;
 			goto fail0;
-- 
1.7.10.4
