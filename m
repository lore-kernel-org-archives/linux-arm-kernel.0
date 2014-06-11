From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 11 Jun 2014 12:01:58 +0530
Subject: [PATCH 2/2 v3] ARM: DTS: move "cs-gpio" from "controller-data" to
 under spi node
In-Reply-To: <1402468318-7342-1-git-send-email-ch.naveen@samsung.com>
References: <1402468318-7342-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1402468318-7342-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the "cs-gpio" field from "controller-data" child
node to under the spi device node.

Respective changes are preposed to spi-s3c64xx.c driver.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Tomasz Figa <t.figa@samsung.com>
---
Changes since v2:
None

 arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts   |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 636d166..9191491 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -169,6 +169,7 @@
 
 	spi_2: spi at 13940000 {
 		status = "okay";
+		cs-gpios = <&gpc1 2 0>;
 
 		w25x80 at 0 {
 			#address-cells = <1>;
@@ -178,7 +179,6 @@
 			spi-max-frequency = <1000000>;
 
 			controller-data {
-				cs-gpio = <&gpc1 2 0>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 8a558b7..204b0de 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -512,6 +512,7 @@
 	spi_1: spi at 13930000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_bus>;
+		cs-gpios = <&gpb 5 0>;
 		status = "okay";
 
 		s5c73m3_spi: s5c73m3 {
@@ -519,7 +520,6 @@
 			spi-max-frequency = <50000000>;
 			reg = <0>;
 			controller-data {
-				cs-gpio = <&gpb 5 0>;
 				samsung,spi-feedback-delay = <2>;
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index a794a70..0c6433a 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -316,6 +316,7 @@
 	};
 
 	spi_1: spi at 12d30000 {
+		cs-gpios = <&gpa2 5 0>;
 		status = "okay";
 
 		w25q80bw at 0 {
@@ -326,7 +327,6 @@
 			spi-max-frequency = <1000000>;
 
 			controller-data {
-				cs-gpio = <&gpa2 5 0>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
-- 
1.7.9.5
