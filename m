From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 15:19:43 +0900
Subject: [PATCH 2/7] [media] dvb-frontends: Drop owner assignment from
 platform_driver
In-Reply-To: <1436509188-23320-1-git-send-email-k.kozlowski@samsung.com>
References: <1436509188-23320-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1436509188-23320-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/media/dvb-frontends/rtl2832_sdr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index 7edb885ae9c8..d5b994f17612 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -1538,7 +1538,6 @@ static int rtl2832_sdr_remove(struct platform_device *pdev)
 static struct platform_driver rtl2832_sdr_driver = {
 	.driver = {
 		.name   = "rtl2832_sdr",
-		.owner  = THIS_MODULE,
 	},
 	.probe          = rtl2832_sdr_probe,
 	.remove         = rtl2832_sdr_remove,
-- 
1.9.1
