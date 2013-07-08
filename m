From: b44548@freescale.com (Chao Fu)
Date: Mon, 8 Jul 2013 16:37:02 +0800
Subject: [PATCH 3/3] ARM:dts:vf610-twr:Enable DSPI0 devices and Flash
 at26df081a
In-Reply-To: <1373272622-29064-1-git-send-email-b44548@freescale.com>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
Message-ID: <1373272622-29064-3-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

This patch enables DSPI0 and at26df081a flash device for Vybrid VF610 TOWER board.

Signed-off-by: Chao Fu <b44548@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b3905f5..bc5bf9d 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -36,6 +36,28 @@
 
 };
 
+&dspi0 {
+	spi-num-chipselects = <1>;
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
+		dspi,ctar-dbr = <0>;
+		dspi,ctar-pbr = <0>;
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
