From: daniel@makrotopia.org (Daniel Golle)
Date: Sat, 13 Jan 2018 18:35:59 +0100
Subject: [PATCH v2] ARM: dts: rename oxnas dts files
Message-ID: <20180113173553.GA30727@makrotopia.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other platforms' device-tree files start with a platform prefix, such as
sun7i-a20-*.dts or at91-*.dts.
This naming scheme turns out to be handy when using multi-platform build
systems such as OpenWrt.
Prepend oxnas files with their platform prefix to comply with the naming
scheme already used for most other platforms.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: also apply changes in Makefile

 arch/arm/boot/dts/Makefile                                            | 4 ++--
 arch/arm/boot/dts/{wd-mbwe.dts => ox810se-wd-mbwe.dts}                | 0
 ...pogoplug-series-3.dts => ox820-cloudengines-pogoplug-series-3.dts} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{wd-mbwe.dts => ox810se-wd-mbwe.dts} (100%)
 rename arch/arm/boot/dts/{cloudengines-pogoplug-series-3.dts => ox820-cloudengines-pogoplug-series-3.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..6a014afa0ee5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -711,8 +711,8 @@ dtb-$(CONFIG_ARCH_ACTIONS) += \
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_OXNAS) += \
-	wd-mbwe.dtb \
-	cloudengines-pogoplug-series-3.dtb
+	ox810se-wd-mbwe.dtb \
+	ox820-cloudengines-pogoplug-series-3.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-arrow-sd-600eval.dtb \
diff --git a/arch/arm/boot/dts/wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
similarity index 100%
rename from arch/arm/boot/dts/wd-mbwe.dts
rename to arch/arm/boot/dts/ox810se-wd-mbwe.dts
diff --git a/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts b/arch/arm/boot/dts/ox820-cloudengines-pogoplug-series-3.dts
similarity index 100%
rename from arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
rename to arch/arm/boot/dts/ox820-cloudengines-pogoplug-series-3.dts
-- 
2.15.1
