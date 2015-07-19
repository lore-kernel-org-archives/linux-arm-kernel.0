From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 19 Jul 2015 22:04:59 +0000
Subject: [PATCH V4 RFC 3/3] mxs: enable ocotp for i.MX23 and i.MX28
In-Reply-To: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
References: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1437343499-16422-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables On Chip OTP support for i.MX23 and i.MX28 SoCs,
but keeps the old compatible string.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |    6 ++++--
 arch/arm/boot/dts/imx28.dtsi |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..777e118 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -350,9 +350,11 @@
 			};
 
 			ocotp at 8002c000 {
-				compatible = "fsl,ocotp";
+				compatible = "fsl,imx23-ocotp", "fsl,ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
+				clocks = <&clks 15>;
 			};
 
 			axi-ahb at 8002e000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4e073e8..c5b57d4 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -936,9 +936,11 @@
 			};
 
 			ocotp: ocotp at 8002c000 {
-				compatible = "fsl,ocotp";
+				compatible = "fsl,imx28-ocotp", "fsl,ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
+				clocks = <&clks 25>;
 			};
 
 			axi-ahb at 8002e000 {
-- 
1.7.9.5
