From: emilio.lopez@collabora.co.uk (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 21 Sep 2015 10:38:23 -0300
Subject: [PATCH v3 4/4] ARM: dts: Enable EC vboot context support on Peach
 boards
In-Reply-To: <1442842703-5309-1-git-send-email-emilio.lopez@collabora.co.uk>
References: <1442842703-5309-1-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <1442842703-5309-5-git-send-email-emilio.lopez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Peach boards use the EC to store the vboot context information,
so add the corresponding properties on the EC node to indicate so.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---

Changes from v1:
 - none

Changes from v2:
 - collect tags from Krzysztof & Javier

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 8f4d76c..ac02fb4 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -935,6 +935,7 @@
 		pinctrl-0 = <&ec_spi_cs &ec_irq>;
 		reg = <0>;
 		spi-max-frequency = <3125000>;
+		google,has-vbc-nvram;
 
 		controller-data {
 			samsung,spi-feedback-delay = <1>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7d5b386..b60dec0 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -898,6 +898,7 @@
 		pinctrl-0 = <&ec_spi_cs &ec_irq>;
 		reg = <0>;
 		spi-max-frequency = <3125000>;
+		google,has-vbc-nvram;
 
 		controller-data {
 			samsung,spi-feedback-delay = <1>;
-- 
2.1.4
