From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:33:01 +0100
Subject: Applied "spi: s3c64xx: add exynos5433 spi compatible" to the spi tree
In-Reply-To: <1467989201-14661-2-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bNjZN-0001qI-NZ@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: add exynos5433 spi compatible

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c068042bf0872c9121f4a6eab281dd63f61df5d3 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 12 Jul 2016 19:02:10 +0900
Subject: [PATCH] spi: s3c64xx: add exynos5433 spi compatible

The samsung,exynos5433-spi has some peculiarities that bring the
need of creating a new compatible in the binding.

One of those is the 3-clocks controller management where the spi
is fed with three clocks: "spi", "busclkN" and "ioclk".

By adding the exynos5433-spi, we deprecate the exynos7 compatible
and discourage its use.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Michael Turquette <mturquette@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 930bc7349271..ab4f0a46e859 100644
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
