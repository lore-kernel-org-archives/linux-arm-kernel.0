From: b32955@freescale.com (Huang Shijie)
Date: Fri, 18 Oct 2013 10:32:53 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sl-evk: enable the SPI NOR
In-Reply-To: <1382063573-21326-1-git-send-email-b32955@freescale.com>
References: <1382063573-21326-1-git-send-email-b32955@freescale.com>
Message-ID: <1382063573-21326-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the spi nor for imx6sl-evk boards.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 36ea01e..006dffa 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -41,6 +41,22 @@
 	};
 };
 
+&ecspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 11 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
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
 	pinctrl-0 = <&pinctrl_fec_1>;
-- 
1.7.2.rc3
