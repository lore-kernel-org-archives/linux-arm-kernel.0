From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 11 Aug 2015 13:30:18 +0000
Subject: [PATCH V5 3/3] ARM: mxs: enable ocotp for i.MX23 and i.MX28
In-Reply-To: <1439299818-8495-1-git-send-email-stefan.wahren@i2se.com>
References: <1439299818-8495-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1439299818-8495-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables On Chip OTP support for i.MX23 and i.MX28 SoCs,
but keeps the old compatible string.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |    7 +++++--
 arch/arm/boot/dts/imx28.dtsi |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index b995333..0541563 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -383,9 +383,12 @@
 			};
 
 			ocotp at 8002c000 {
-				compatible = "fsl,ocotp";
+				compatible = "fsl,imx23-ocotp", "fsl,ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
+				clocks = <&clks 15>;
+				status = "okay";
 			};
 
 			axi-ahb at 8002e000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4e073e8..648d790 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -936,9 +936,12 @@
 			};
 
 			ocotp: ocotp at 8002c000 {
-				compatible = "fsl,ocotp";
+				compatible = "fsl,imx28-ocotp", "fsl,ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
+				clocks = <&clks 25>;
+				status = "okay";
 			};
 
 			axi-ahb at 8002e000 {
-- 
1.7.9.5
