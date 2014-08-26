From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Aug 2014 00:40:16 +0200
Subject: [PATCH] iio: adc: rockchip_saradc: remove unused variable in probe
Message-ID: <2134722.Yfu4MZ4klm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rate variable in the probe function of the saradc is a remnant
of a previous patch iteration. It is unused and thus produces a
compile time warning. Therefore remove it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/iio/adc/rockchip_saradc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 1fad964..e074a0b 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -141,7 +141,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	struct resource	*mem;
 	int ret;
 	int irq;
-	u32 rate;
 
 	if (!np)
 		return -ENODEV;
-- 
2.0.1
