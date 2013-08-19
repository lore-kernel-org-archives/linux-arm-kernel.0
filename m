From: b32955@freescale.com (Huang Shijie)
Date: Mon, 19 Aug 2013 12:10:03 +0800
Subject: [PATCH V1 5/5] ARM: dts: vf610-twr: Add SPI NOR support
In-Reply-To: <1376885403-12156-1-git-send-email-b32955@freescale.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
Message-ID: <1376885403-12156-6-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vf610-twr has a s25fl128s SPI NOR flash connected to QuadSpi0.

Add support for it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b3905f5..d57ce8e 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -55,3 +55,25 @@
 	pinctrl-0 = <&pinctrl_uart1_1>;
 	status = "okay";
 };
+
+&qspi0 {
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0_1>;
+	fsl,nor-size = <0x1000000>;
+	status = "okay";
+
+	flash: s25fl128s at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <20000000>;
+		m25p,quad-read = <1>;
+		reg = <0>;
+
+		partition at 0 {
+			label = "s25fl128s";
+			reg = <0x0 0x1000000>;
+		};
+	};
+};
-- 
1.7.1
