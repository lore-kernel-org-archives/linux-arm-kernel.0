From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 15 Sep 2017 19:29:42 +0200
Subject: [PATCH 2/2] [media] stm32-dcmi: Improve four size determinations
In-Reply-To: <730b535e-39a5-2c2b-f463-e76da967a723@users.sourceforge.net>
References: <730b535e-39a5-2c2b-f463-e76da967a723@users.sourceforge.net>
Message-ID: <f4e400ea-9660-05cd-3194-cdf2495a2376@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 15 Sep 2017 18:48:14 +0200

Replace the specification of data types by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index df12d10bd230..c4895cc95cc1 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1372,9 +1372,8 @@ static int dcmi_formats_init(struct stm32_dcmi *dcmi)
 	dcmi->sd_formats = devm_kcalloc(dcmi->dev,
-					num_fmts, sizeof(struct dcmi_format *),
+					num_fmts, sizeof(*dcmi->sd_formats),
 					GFP_KERNEL);
 	if (!dcmi->sd_formats)
 		return -ENOMEM;
 
-	memcpy(dcmi->sd_formats, sd_fmts,
-	       num_fmts * sizeof(struct dcmi_format *));
+	memcpy(dcmi->sd_formats, sd_fmts, num_fmts * sizeof(*dcmi->sd_formats));
 	dcmi->sd_format = dcmi->sd_formats[0];
@@ -1406,3 +1405,3 @@ static int dcmi_framesizes_init(struct stm32_dcmi *dcmi)
 	dcmi->sd_framesizes = devm_kcalloc(dcmi->dev, num_fsize,
-					   sizeof(struct dcmi_framesize),
+					   sizeof(*dcmi->sd_framesizes),
 					   GFP_KERNEL);
@@ -1570,5 +1569,5 @@ static int dcmi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	dcmi = devm_kzalloc(&pdev->dev, sizeof(struct stm32_dcmi), GFP_KERNEL);
+	dcmi = devm_kzalloc(&pdev->dev, sizeof(*dcmi), GFP_KERNEL);
 	if (!dcmi)
-- 
2.14.1
