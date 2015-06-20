From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 20 Jun 2015 19:12:40 +0200
Subject: [PATCH v3 6/6] apf27: dt: add support of internal rtc
In-Reply-To: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1434820360-21935-7-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the internal mxc rtc driver on apf27.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27-apf27.dts |    4 ++++
 arch/arm/boot/dts/imx27.dtsi      |   10 ++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 73aae4f..590d37a 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -122,3 +122,7 @@
 		reg = <0x800000 0xf800000>;
 	};
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index bc215e4..57fda6c 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -144,6 +144,16 @@
 				clock-names = "ipg", "per";
 			};
 
+			rtc: rtc at 10007000 {
+				compatible = "fsl,imx21-rtc";
+				reg = <0x10007000 0x1000>;
+				interrupts = <22>;
+				clocks = <&clks IMX27_CLK_CKIL>,
+					 <&clks IMX27_CLK_RTC_IPG_GATE>;
+				clock-names = "rtc", "ipg";
+				status = "disabled";
+			};
+
 			kpp: kpp at 10008000 {
 				compatible = "fsl,imx27-kpp", "fsl,imx21-kpp";
 				reg = <0x10008000 0x1000>;
-- 
1.7.4.4
