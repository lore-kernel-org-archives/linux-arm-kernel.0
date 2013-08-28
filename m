From: b44548@freescale.com (Chao Fu)
Date: Wed, 28 Aug 2013 15:08:44 +0800
Subject: [PATCH v3 resend 2/2] ARM:dts:vf610-twr:Enable DSPI0 devices and
 Flash at26df081a
In-Reply-To: <1377673724-32468-1-git-send-email-b44548@freescale.com>
References: <1377673724-32468-1-git-send-email-b44548@freescale.com>
Message-ID: <1377673724-32468-2-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

This patch enables DSPI0 and at26df081a flash device for Vybrid VF610
TOWER board.

Signed-off-by: Chao Fu <b44548@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b3905f5..d29226c 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -36,6 +36,25 @@
 
 };
 
+&dspi0 {
+	bus-num = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dspi0_1>;
+	status = "okay";
+
+	sflash: at26df081a at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at26df081a";
+		spi-max-frequency = <16000000>;
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		linux,modalias = "m25p80";
+		modal = "at26df081a";
+	};
+};
+
 &fec0 {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
-- 
1.8.0
