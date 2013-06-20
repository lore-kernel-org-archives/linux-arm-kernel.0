From: b32955@freescale.com (Huang Shijie)
Date: Thu, 20 Jun 2013 14:00:10 +0800
Subject: [PATCH 3/3] ARM: dts: imx6qdl-sabresd: enable the SPI NOR
In-Reply-To: <1371708010-22710-1-git-send-email-b32955@freescale.com>
References: <1371708010-22710-1-git-send-email-b32955@freescale.com>
Message-ID: <1371708010-22710-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the spi nor for imx6q{dl}-sabresd boards.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 6e5dfdb..4dec80c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -77,6 +77,22 @@
 	status = "okay";
 };
 
+&ecspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 9 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_2>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p32";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_1>;
-- 
1.7.1
