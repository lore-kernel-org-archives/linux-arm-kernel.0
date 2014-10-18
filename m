From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 18 Oct 2014 10:32:52 +0000
Subject: [PATCH RFC V3 3/3] mxs: enable ocotp for i.MX23 and i.MX28
In-Reply-To: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1413628372-2809-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables On Chip OTP support for i.MX23 and i.MX28 SoCs,
but keeps the old compatible string.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |    3 +--
 arch/arm/boot/dts/imx28.dtsi |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..677d937 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -350,9 +350,8 @@
 			};
 
 			ocotp at 8002c000 {
-				compatible = "fsl,ocotp";
+				compatible = "fsl,imx23-ocotp", "fsl,ocotp";
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
 			};
 
 			axi-ahb at 8002e000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 47f68ac..f4e0ebb 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -923,9 +923,8 @@
 			};
 
 			ocotp: ocotp at 8002c000 {
-				compatible = "fsl,ocotp";
+				compatible = "fsl,imx28-ocotp", "fsl,ocotp";
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
 			};
 
 			axi-ahb at 8002e000 {
-- 
1.7.9.5
