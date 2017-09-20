From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 20 Sep 2017 10:17:55 -0500
Subject: [PATCHv2] arm64: dts: stratix10: add ethernet/sdmmc support to the
 S10 devkit
Message-ID: <1505920675-9641-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ethernet and sdmmc support on the Stratix10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: Create a separate PHY node
---
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 41ea2db..5907586 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -34,6 +34,44 @@
 	};
 };
 
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&phy0>;
+
+	max-frame-size = <3800>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy at 0 {
+			reg = <4>;
+
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			rxd0-skew-ps = <420>; /* 0ps */
+			rxd1-skew-ps = <420>; /* 0ps */
+			rxd2-skew-ps = <420>; /* 0ps */
+			rxd3-skew-ps = <420>; /* 0ps */
+			txen-skew-ps = <0>; /* -420ps */
+			txc-skew-ps = <1860>; /* 960ps */
+			rxdv-skew-ps = <420>; /* 0ps */
+			rxc-skew-ps = <1680>; /* 780ps */
+		};
+	};
+};
+
+&mmc {
+	status = "okay";
+	num-slots = <1>;
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.7.4
