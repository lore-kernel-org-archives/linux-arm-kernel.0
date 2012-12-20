From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Dec 2012 11:03:37 -0800
Subject: [PATCH] ARM: dts: fix split memory bank for SSDK5440
Message-ID: <1356030217-5472-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size of memory bank should be under 256MB, because current
section size is 256MB on EXYNOS SoCs. This patch fixes it.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index 44d4d24..79d02cc 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -17,7 +17,14 @@
 	compatible = "samsung,ssdk5440", "samsung,exynos5440";
 
 	memory {
-		reg = <0x80000000 0x80000000>;
+		reg = <0x80000000 0x10000000
+		       0x90000000 0x10000000
+		       0xA0000000 0x10000000
+		       0xB0000000 0x10000000
+		       0xC0000000 0x10000000
+		       0xD0000000 0x10000000
+		       0xE0000000 0x10000000
+		       0xF0000000 0x10000000>;
 	};
 
 	chosen {
-- 
1.7.10.4
