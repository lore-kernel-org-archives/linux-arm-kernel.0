From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Jun 2013 17:14:57 +0900
Subject: [PATCH] ARM: dts: update bootargs to support 8GiB for SSDK5440 and
 SD5v1
Message-ID: <109a01ce667b$c2d45930$487d0b90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subash Patel <subash.rp@samsung.com>

Since ssdk5440 and sd5v1 have 8GiB memory, this patch
updates bootargs for them.

Signed-off-by: Subash Patel <subash.rp@samsung.com>
Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440-sd5v1.dts    |    2 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
index ef747b5..f722a02 100644
--- a/arch/arm/boot/dts/exynos5440-sd5v1.dts
+++ b/arch/arm/boot/dts/exynos5440-sd5v1.dts
@@ -17,7 +17,7 @@
 	compatible = "samsung,sd5v1", "samsung,exynos5440";
 
 	chosen {
-		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel early_printk no_console_suspend mem=2048M at 0x80000000
console=ttySAC0,115200";
+		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel early_printk no_console_suspend mem=2048M at 0x80000000
mem=6144M at 0x100000000 console=ttySAC0,115200";
 	};
 
 	fixed-rate-clocks {
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index d55042b..0e3adc8 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -17,7 +17,7 @@
 	compatible = "samsung,ssdk5440", "samsung,exynos5440";
 
 	chosen {
-		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel early_printk no_console_suspend mem=2048M at 0x80000000
console=ttySAC0,115200";
+		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel early_printk no_console_suspend mem=2048M at 0x80000000
mem=6144M at 0x100000000 console=ttySAC0,115200";
 	};
 
 	spi {
-- 
1.7.10.4
