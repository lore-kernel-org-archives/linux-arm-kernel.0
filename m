From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Mon,  7 Sep 2015 10:23:01 +0300
Subject: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
Message-ID: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
build error here because it removed the type LPSS_SSP and I didn't notice
the type was used here too.

I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
accidentally by copying all enum pxa_ssp_type types from
include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.

Fix the build error by removing this incorrect binding.

Fixes: 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Axel Lin <axel.lin@ingics.com>
Cc: <stable@vger.kernel.org> # 4.2
---
v2: Added Fixes tag suggested by Robert Jarzmik
---
 arch/arm/plat-pxa/ssp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ad9529cc4203..daa1a65f2eb7 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -107,7 +107,6 @@ static const struct of_device_id pxa_ssp_of_ids[] = {
 	{ .compatible = "mvrl,pxa168-ssp",	.data = (void *) PXA168_SSP },
 	{ .compatible = "mrvl,pxa910-ssp",	.data = (void *) PXA910_SSP },
 	{ .compatible = "mrvl,ce4100-ssp",	.data = (void *) CE4100_SSP },
-	{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pxa_ssp_of_ids);
-- 
2.5.1
