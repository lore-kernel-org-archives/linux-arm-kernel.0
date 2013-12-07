From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  7 Dec 2013 12:26:36 +0400
Subject: [PATCH 5/5] ARM: dts: imx27-phytec-phycore-som: Rename file to .dtsi
In-Reply-To: <1386404796-8848-1-git-send-email-shc_work@mail.ru>
References: <1386404796-8848-1-git-send-email-shc_work@mail.ru>
Message-ID: <1386404796-8848-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCM-038 module cannot be used standalone. This patch renames
module file to .dtsi and excludes it from compilation.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile                                              | 1 -
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts                          | 2 +-
 .../dts/{imx27-phytec-phycore-som.dts => imx27-phytec-phycore-som.dtsi} | 0
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename arch/arm/boot/dts/{imx27-phytec-phycore-som.dts => imx27-phytec-phycore-som.dtsi} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 648c016..88cd3d9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -124,7 +124,6 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-apf27.dtb \
 	imx27-apf27dev.dtb \
 	imx27-pdk.dtb \
-	imx27-phytec-phycore-som.dtb \
 	imx27-phytec-phycore-rdk.dtb \
 	imx27-phytec-phycard-s-som.dtb \
 	imx27-phytec-phycard-s-rdk.dtb \
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 0903e3a..7ada054 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -7,7 +7,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "imx27-phytec-phycore-som.dts"
+#include "imx27-phytec-phycore-som.dtsi"
 
 / {
 	model = "Phytec pcm970";
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx27-phytec-phycore-som.dts
rename to arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
-- 
1.8.3.2
