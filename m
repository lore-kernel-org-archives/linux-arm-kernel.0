From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 11:01:52 +0100
Subject: [PATCH v3][ 3/9] usb: chipidea: Use standard usb-phy property.
In-Reply-To: <1394618518-13803-1-git-send-email-denis@eukrea.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
Message-ID: <1394618518-13803-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the Chipidea usbmisc driver to
use the standard usb-phy property.

It also adapt the dts that uses it.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx23.dtsi       |    2 +-
 arch/arm/boot/dts/imx27.dtsi       |    4 ++--
 arch/arm/boot/dts/imx28.dtsi       |    4 ++--
 arch/arm/boot/dts/imx51.dtsi       |    2 +-
 arch/arm/boot/dts/imx53.dtsi       |    4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi     |    4 ++--
 arch/arm/boot/dts/imx6sl.dtsi      |    4 ++--
 drivers/usb/chipidea/ci_hdrc_imx.c |    2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..e3c9924 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -522,7 +522,7 @@
 			compatible = "fsl,imx23-usb", "fsl,imx27-usb";
 			reg = <0x80080000 0x40000>;
 			interrupts = <11>;
-			fsl,usbphy = <&usbphy0>;
+			usb-phy = <&usbphy0>;
 			clocks = <&clks 40>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 83a8247..94bcf1a 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -466,7 +466,7 @@
 				interrupts = <56>;
 				clocks = <&clks 15>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,usbphy = <&usbphy0>;
+				usb-phy = <&usbphy0>;
 				status = "disabled";
 			};
 
@@ -485,7 +485,7 @@
 				interrupts = <55>;
 				clocks = <&clks 15>;
 				fsl,usbmisc = <&usbmisc 2>;
-				fsl,usbphy = <&usbphy2>;
+				usb-phy = <&usbphy2>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 90a5795..52ad72f 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1143,7 +1143,7 @@
 			reg = <0x80080000 0x10000>;
 			interrupts = <93>;
 			clocks = <&clks 60>;
-			fsl,usbphy = <&usbphy0>;
+			usb-phy = <&usbphy0>;
 			status = "disabled";
 		};
 
@@ -1152,7 +1152,7 @@
 			reg = <0x80090000 0x10000>;
 			interrupts = <92>;
 			clocks = <&clks 61>;
-			fsl,usbphy = <&usbphy1>;
+			usb-phy = <&usbphy1>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index cb3204a..b290947 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -249,7 +249,7 @@
 				interrupts = <18>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,usbphy = <&usbphy0>;
+				usb-phy = <&usbphy0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index f0962e5..b10a3de 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -276,7 +276,7 @@
 				interrupts = <18>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,usbphy = <&usbphy0>;
+				usb-phy = <&usbphy0>;
 				status = "disabled";
 			};
 
@@ -286,7 +286,7 @@
 				interrupts = <14>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 1>;
-				fsl,usbphy = <&usbphy1>;
+				usb-phy = <&usbphy1>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index cfc85be..d2f0087 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -789,7 +789,7 @@
 				reg = <0x02184000 0x200>;
 				interrupts = <0 43 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks 162>;
-				fsl,usbphy = <&usbphy1>;
+				usb-phy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
@@ -799,7 +799,7 @@
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks 162>;
-				fsl,usbphy = <&usbphy2>;
+				usb-phy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 6477447..33f501a 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -651,7 +651,7 @@
 				reg = <0x02184000 0x200>;
 				interrupts = <0 43 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
-				fsl,usbphy = <&usbphy1>;
+				usb-phy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
@@ -661,7 +661,7 @@
 				reg = <0x02184200 0x200>;
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
-				fsl,usbphy = <&usbphy2>;
+				usb-phy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index c00f772..9a74100 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -130,7 +130,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
+	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
 	if (IS_ERR(data->phy)) {
 		ret = PTR_ERR(data->phy);
 		goto err_clk;
-- 
1.7.9.5
