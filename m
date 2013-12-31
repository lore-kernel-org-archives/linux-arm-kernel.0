From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 31 Dec 2013 11:51:16 +0100
Subject: [ARM] Fix kernel compile error: drivers/crypto/ixp4xx_crypto.c.
Message-ID: <m3d2kduwd7.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/crypto/ixp4xx_crypto.c: In function 'ixp_module_init':
drivers/crypto/ixp4xx_crypto.c:1419:2: error: 'dev' undeclared (first use in this function)

Now builds. Not tested on real hw.

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -1410,14 +1410,12 @@ static const struct platform_device_info ixp_dev_info __initdata = {
 static int __init ixp_module_init(void)
 {
 	int num = ARRAY_SIZE(ixp4xx_algos);
-	int i, err ;
+	int i, err;
 
 	pdev = platform_device_register_full(&ixp_dev_info);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
-	dev = &pdev->dev;
-
 	spin_lock_init(&desc_lock);
 	spin_lock_init(&emerg_lock);
 

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
