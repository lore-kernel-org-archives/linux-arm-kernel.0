From: stefan@agner.ch (Stefan Agner)
Date: Sun, 28 Aug 2016 22:13:22 -0700
Subject: [PATCH 1/3] ARM: dts: imx7-colibri: move SD-card to module level
Message-ID: <20160829051324.2276-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move SD-card definition to module level. While at it, also disable
write-protect since the Colibri standard does not define a pin for
SD-Card write-protection.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 4 ----
 arch/arm/boot/dts/imx7-colibri.dtsi         | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 1545661..373ee19 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -138,10 +138,6 @@
 };
 
 &usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
-	no-1-8-v;
-	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	keep-power-in-suspend;
 	wakeup-source;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 0a9d3a8..044b83e 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -251,6 +251,14 @@
 	dr_mode = "host";
 };
 
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
+	no-1-8-v;
+	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+	disable-wp;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4>;
-- 
2.9.0
