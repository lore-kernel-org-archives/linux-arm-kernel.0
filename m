From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:42 +0200
Subject: [PATCH 10/10] ARM: imx: add mxc_nand to imx27 device tree
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi |    9 +++++++++
 arch/arm/mach-imx/imx27-dt.c |    1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index bc5e7d5..5a41b8a 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -213,5 +213,14 @@
 				status = "disabled";
 			};
 		};
+		nand at d8000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			compatible = "fsl,imx27-nand";
+			reg = <0xd8000000 0x1000>;
+			interrupts = <29>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 861ceb8..9853319 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -29,6 +29,7 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI2_BASE_ADDR, "imx27-cspi.1", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI3_BASE_ADDR, "imx27-cspi.2", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-wdt", MX27_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-nand", MX27_NFC_BASE_ADDR, "mxc_nand.0", NULL),
 	{ /* sentinel */ }
 };
 
-- 
1.7.10
