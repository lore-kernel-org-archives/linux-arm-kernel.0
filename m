From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:20:27 +0100
Subject: [PATCH 11/35 linux-next] usb: gadget: constify of_device_id array
In-Reply-To: <1426533651-25586-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
Message-ID: <1426533651-25586-2-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 486f754..b51226a 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2387,7 +2387,7 @@ static struct pxa_udc memory = {
 };
 
 #if defined(CONFIG_OF)
-static struct of_device_id udc_pxa_dt_ids[] = {
+static const struct of_device_id udc_pxa_dt_ids[] = {
 	{ .compatible = "marvell,pxa270-udc" },
 	{}
 };
-- 
2.1.0
