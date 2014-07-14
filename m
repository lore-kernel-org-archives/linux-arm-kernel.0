From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Mon, 14 Jul 2014 11:11:46 +0530
Subject: [PATCH 3/3 v6] ARM: DTS: fix the chip select gpios definition in the
 SPI nodes
In-Reply-To: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1405316506-27855-4-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the "cs-gpio" from "controller-data" node
as was specified in the old binding and use the standard
"cs-gpios" property expected by the SPI core as is defined in
the new binding.

Respective changes are preposed to spi-s3c64xx.c driver.
@ http://www.spinics.net/lists/linux-samsung-soc/msg32282.html

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Cc: Tomasz Figa <t.figa@samsung.com>
---
Changes since v5:
None

Changes since v4:
1. Added reviewed by from Javier and Doug.
2. Maintained the "status" and "cs-gpios" ordering

Changes since v3:
None
 arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts   |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 636d166..676e6e0 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -168,6 +168,7 @@
 	};
 
 	spi_2: spi at 13940000 {
+		cs-gpios = <&gpc1 2 0>;
 		status = "okay";
 
 		w25x80 at 0 {
@@ -178,7 +179,6 @@
 			spi-max-frequency = <1000000>;
 
 			controller-data {
-				cs-gpio = <&gpc1 2 0>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 7787844..11967f4 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -589,6 +589,7 @@
 	spi_1: spi at 13930000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_bus>;
+		cs-gpios = <&gpb 5 0>;
 		status = "okay";
 
 		s5c73m3_spi: s5c73m3 {
@@ -596,7 +597,6 @@
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
