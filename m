From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 23:46:35 +0900
Subject: [PATCH v2 1/7] bindings: spi-samsung: add exynos5433 spi compatible
In-Reply-To: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467989201-14661-2-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung,exynos5433-spi has some peculiarities that bring the
need of creating a new compatible in the binding.

One of those is the 3-clocks controller management where the spi
is fed with three clocks: "spi", "busclkN" and "ioclk".

By adding the exynos5433-spi, we deprecate the exynos7 compatible
and discourage its use.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 6dbdeb3..57d5539 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -9,7 +9,8 @@ Required SoC Specific Properties:
     - samsung,s3c2443-spi: for s3c2443, s3c2416 and s3c2450 platforms
     - samsung,s3c6410-spi: for s3c6410 platforms
     - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
-    - samsung,exynos7-spi: for exynos7 platforms
+    - samsung,exynos5433-spi: for exynos5433 compatible controllers
+    - samsung,exynos7-spi: for exynos7 platforms <DEPRECATED>
 
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
2.8.1
