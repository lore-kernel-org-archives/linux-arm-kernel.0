From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  8 Sep 2017 10:48:54 -0500
Subject: [PATCH 2/2] arm64: dts: stratix10: add ethernet/sdmmc support to the
 S10 devkit
In-Reply-To: <1504885734-9618-1-git-send-email-dinguyen@kernel.org>
References: <1504885734-9618-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1504885734-9618-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ethernet and sdmmc support on the Stratix10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 41ea2db..ae0e8f3 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -34,6 +34,42 @@
 	};
 };
 
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-addr = <0xffffffff>; /* probe for phy addr */
+
+	/*
+	 * These skews assume the user's FPGA design is adding 600ps of delay
+	 * for TX_CLK on Arria 10.
+	 *
+	 * All skews are offset since hardware skew values for the ksz9031
+	 * range from a negative skew to a positive skew.
+	 * See the micrel-ksz90x1.txt Documentation file for details.
+	*/
+	txd0-skew-ps = <0>; /* -420ps */
+	txd1-skew-ps = <0>; /* -420ps */
+	txd2-skew-ps = <0>; /* -420ps */
+	txd3-skew-ps = <0>; /* -420ps */
+	rxd0-skew-ps = <420>; /* 0ps */
+	rxd1-skew-ps = <420>; /* 0ps */
+	rxd2-skew-ps = <420>; /* 0ps */
+	rxd3-skew-ps = <420>; /* 0ps */
+	txen-skew-ps = <0>; /* -420ps */
+	txc-skew-ps = <1860>; /* 960ps */
+	rxdv-skew-ps = <420>; /* 0ps */
+	rxc-skew-ps = <1680>; /* 780ps */
+	max-frame-size = <3800>;
+	status = "okay";
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
