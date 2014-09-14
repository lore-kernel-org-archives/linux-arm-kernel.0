From: ijc@hellion.org.uk (Ian Campbell)
Date: Sun, 14 Sep 2014 20:29:41 +0100
Subject: [PATCH] ARM: dts: exynos: Only build DTS files for subarches which
 are enabled
Message-ID: <1410722981-6600-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we build all Exynos dtb files if CONFIG_ARCH_EXYNOS is enabled, even
if the corresponding CONFIG_ARCH_EXYNOS[345] subarch is not enabled, meaning we
may build dtbs for things which can't actually run in a particular
configuration.

Switch instead to using the subarch option, based purely on the filename which
I assume matches. Note that there doesn't apear to be any Exynos3 board files
right now (or I have somehow missed them).

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 arch/arm/boot/dts/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index adb5ed9..1538378 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -62,7 +62,7 @@ dtb-$(CONFIG_ARCH_BERLIN) += \
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
-dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
+dtb-$(CONFIG_ARCH_EXYNOS4) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
 	exynos4210-universal_c210.dtb \
@@ -71,7 +71,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4412-smdk4412.dtb \
 	exynos4412-tiny4412.dtb \
 	exynos4412-trats2.dtb \
-	exynos5250-arndale.dtb \
+dtb-$(CONFIG_ARCH_EXYNOS5) += exynos5250-arndale.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
 	exynos5260-xyref5260.dtb \
-- 
1.7.10.4
