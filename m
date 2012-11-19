From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:19:55 -0500
Subject: [PATCH 046/493] hwrng: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-46-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/char/hw_random/atmel-rng.c      | 2 +-
 drivers/char/hw_random/bcm63xx-rng.c    | 2 +-
 drivers/char/hw_random/exynos-rng.c     | 2 +-
 drivers/char/hw_random/n2-drv.c         | 2 +-
 drivers/char/hw_random/picoxcell-rng.c  | 2 +-
 drivers/char/hw_random/timeriomem-rng.c | 2 +-
 drivers/char/hw_random/virtio-rng.c     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 731c904..0f6ca8f 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -138,7 +138,7 @@ static const struct dev_pm_ops atmel_trng_pm_ops = {
 
 static struct platform_driver atmel_trng_driver = {
 	.probe		= atmel_trng_probe,
-	.remove		= __devexit_p(atmel_trng_remove),
+	.remove		= atmel_trng_remove,
 	.driver		= {
 		.name	= "atmel-trng",
 		.owner	= THIS_MODULE,
diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index aec6a42..95bcc88 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -161,7 +161,7 @@ static int __devexit bcm63xx_rng_remove(struct platform_device *pdev)
 
 static struct platform_driver bcm63xx_rng_driver = {
 	.probe		= bcm63xx_rng_probe,
-	.remove		= __devexit_p(bcm63xx_rng_remove),
+	.remove		= bcm63xx_rng_remove,
 	.driver		= {
 		.name	= "bcm63xx-rng",
 		.owner	= THIS_MODULE,
diff --git a/drivers/char/hw_random/exynos-rng.c b/drivers/char/hw_random/exynos-rng.c
index 232ba9c..046d6ae 100644
--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -172,7 +172,7 @@ static struct platform_driver exynos_rng_driver = {
 		.pm	= &exynos_rng_pm_ops,
 	},
 	.probe		= exynos_rng_probe,
-	.remove		= __devexit_p(exynos_rng_remove),
+	.remove		= exynos_rng_remove,
 };
 
 module_platform_driver(exynos_rng_driver);
diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index ebd48f0..cbde832 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -767,7 +767,7 @@ static struct platform_driver n2rng_driver = {
 		.of_match_table = n2rng_match,
 	},
 	.probe		= n2rng_probe,
-	.remove		= __devexit_p(n2rng_remove),
+	.remove		= n2rng_remove,
 };
 
 module_platform_driver(n2rng_driver);
diff --git a/drivers/char/hw_random/picoxcell-rng.c b/drivers/char/hw_random/picoxcell-rng.c
index 97bd891..b4f7f06 100644
--- a/drivers/char/hw_random/picoxcell-rng.c
+++ b/drivers/char/hw_random/picoxcell-rng.c
@@ -181,7 +181,7 @@ static const struct dev_pm_ops picoxcell_trng_pm_ops = {
 
 static struct platform_driver picoxcell_trng_driver = {
 	.probe		= picoxcell_trng_probe,
-	.remove		= __devexit_p(picoxcell_trng_remove),
+	.remove		= picoxcell_trng_remove,
 	.driver		= {
 		.name	= "picoxcell-trng",
 		.owner	= THIS_MODULE,
diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
index f1a1618..d5144ec 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -146,7 +146,7 @@ static struct platform_driver timeriomem_rng_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= timeriomem_rng_probe,
-	.remove		= __devexit_p(timeriomem_rng_remove),
+	.remove		= timeriomem_rng_remove,
 };
 
 module_platform_driver(timeriomem_rng_driver);
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 5708299..bb78033 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -147,7 +147,7 @@ static struct virtio_driver virtio_rng_driver = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtrng_probe,
-	.remove =	__devexit_p(virtrng_remove),
+	.remove =	virtrng_remove,
 #ifdef CONFIG_PM
 	.freeze =	virtrng_freeze,
 	.restore =	virtrng_restore,
-- 
1.8.0
