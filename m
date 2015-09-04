From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Fri,  4 Sep 2015 11:05:40 +0300
Subject: [PATCH] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
Message-ID: <1441353940-9262-1-git-send-email-jarkko.nikula@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
build error here because it removed the type LPSS_SSP and I didn't notice
the type was used here too.

I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
accidentally by copying all enum pxa_ssp_type types from
include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.

Fix the build error by removing this incorrect binding.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Axel Lin <axel.lin@ingics.com>
Cc: <stable@vger.kernel.org> # 4.2
---
Sorry if you got this multiple times day before yesterday. I had problems
with two addresses bouncing back without any obvious errors in the
git send-email command or those failing addresses and linux-spi archive
didn't show the patch either.

I'm surrounding now the stable at vger.kernel.org by angled brackets because I
think that was the problem here as the "# 4.2" got added into address.
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
