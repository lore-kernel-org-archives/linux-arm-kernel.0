From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Apr 2018 22:32:34 +0200
Subject: [RFC 05/10] i2c: s3c2410: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Message-ID: <20180424203239.21885-6-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt | 4 +---
 drivers/i2c/busses/i2c-s3c2410.c                      | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
index 89b3250f049b..66ae46d3bc2f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
@@ -8,9 +8,7 @@ Required properties:
       (b) "samsung, s3c2440-i2c", for i2c compatible with s3c2440 i2c.
       (c) "samsung, s3c2440-hdmiphy-i2c", for s3c2440-like i2c used
           inside HDMIPHY block found on several samsung SoCs
-      (d) "samsung, exynos5440-i2c", for s3c2440-like i2c used
-	   on EXYNOS5440 which does not need GPIO configuration.
-      (e) "samsung, exynos5-sata-phy-i2c", for s3c2440-like i2c used as
+      (d) "samsung, exynos5-sata-phy-i2c", for s3c2440-like i2c used as
 	   a host to SATA PHY controller on an internal bus.
   - reg: physical base address of the controller and length of memory mapped
     region.
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5d97510ee48b..9fe2b6951895 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -154,8 +154,6 @@ static const struct of_device_id s3c24xx_i2c_match[] = {
 	{ .compatible = "samsung,s3c2440-i2c", .data = (void *)QUIRK_S3C2440 },
 	{ .compatible = "samsung,s3c2440-hdmiphy-i2c",
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO) },
-	{ .compatible = "samsung,exynos5440-i2c",
-	  .data = (void *)(QUIRK_S3C2440 | QUIRK_NO_GPIO) },
 	{ .compatible = "samsung,exynos5-sata-phy-i2c",
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_POLL | QUIRK_NO_GPIO) },
 	{},
-- 
2.14.1
