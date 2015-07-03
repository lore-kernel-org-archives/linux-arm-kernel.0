From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat,  4 Jul 2015 01:15:19 +0200
Subject: [PATCH v4 6/7] imx27: dt: add support of internal rtc
In-Reply-To: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1435965320-1478-7-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support of internal rtc on imx27.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index b69be5c..38e6e84 100644
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
