From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Sep 2018 08:23:01 +0200
Subject: [PATCH v2] ARM: dts: imx53-qsb: disable 1.2GHz OPP
In-Reply-To: <20180910125056.30813-1-s.hauer@pengutronix.de>
References: <20180910125056.30813-1-s.hauer@pengutronix.de>
Message-ID: <20180912062301.3972-1-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum CPU frequency for the i.MX53 QSB is 1GHz, so disable the
1.2GHz OPP. This makes the board work again with configs that have
cpufreq enabled like imx_v6_v7_defconfig on which the board stopped
working with the addition of cpufreq-dt support.

Fixes: 791f416608 ("ARM: dts: imx53: add cpufreq-dt support")

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Changes since v1:
- rephrase commit message

arch/arm/boot/dts/imx53-qsb-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 7423d462d1e4..50dde84b72ed 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -123,6 +123,17 @@
 	};
 };
 
+&cpu0 {
+	/* CPU rated to 1GHz, not 1.2GHz as per the default settings */
+	operating-points = <
+		/* kHz   uV */
+		166666  850000
+		400000  900000
+		800000  1050000
+		1000000 1200000
+	>;
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-- 
2.18.0
