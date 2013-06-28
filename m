From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 28 Jun 2013 14:24:16 +0200
Subject: [PATCH 2/2] ARM i.MX6DL: dts: add clock and mux configuration for LDB
In-Reply-To: <1372422256-22037-1-git-send-email-p.zabel@pengutronix.de>
References: <1372422256-22037-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1372422256-22037-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6DL does not have the second IPU, but the LVDS multiplexers can connect
either LVDS channel of the LDB to IPU1 DI0 or IPU1 DI1.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 80155fde..5ec89eb 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -417,3 +417,20 @@
 		};
 	};
 };
+
+&ldb {
+	clocks = <&clks 33>, <&clks 34>,
+		 <&clks 39>, <&clks 40>,
+		 <&clks 135>, <&clks 136>;
+	clock-names = "di0_pll", "di1_pll",
+		      "di0_sel", "di1_sel",
+		      "di0", "di1";
+
+	lvds-channel at 0 {
+		crtcs = <&ipu1 0>, <&ipu1 1>;
+	};
+
+	lvds-channel at 1 {
+		crtcs = <&ipu1 0>, <&ipu1 1>;
+	};
+};
-- 
1.8.3.1
