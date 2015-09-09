From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 9 Sep 2015 15:47:15 +0200
Subject: [PATCH] drm: atmel-hlcdc: add support for sama5d2 SoCs
Message-ID: <1441806435-12346-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the hardware description for this chip is the same as the sama5d4, we use
this SoC structures for layers and DC descriptions. Thus only 2 lines are added
to the atmel_hlcdc_of_match table.
The compatible string is already documented in the parent MFD driver's binding.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 8bc62ec407f9..498add1e5e58 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -333,6 +333,10 @@ static const struct of_device_id atmel_hlcdc_of_match[] = {
 		.data = &atmel_hlcdc_dc_at91sam9x5,
 	},
 	{
+		.compatible = "atmel,sama5d2-hlcdc",
+		.data = &atmel_hlcdc_dc_sama5d4,
+	},
+	{
 		.compatible = "atmel,sama5d3-hlcdc",
 		.data = &atmel_hlcdc_dc_sama5d3,
 	},
-- 
2.1.3
