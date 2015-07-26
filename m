From: tremyfr@gmail.com (Philippe Reynes)
Date: Sun, 26 Jul 2015 23:37:53 +0200
Subject: [PATCH v5 6/6] imx27: dt: add support of internal rtc
In-Reply-To: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
References: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1437946673-7402-7-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support of internal rtc on imx27.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index b69be5c..feb9d34 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -144,6 +144,15 @@
 				clock-names = "ipg", "per";
 			};
 
+			rtc: rtc at 10007000 {
+				compatible = "fsl,imx21-rtc";
+				reg = <0x10007000 0x1000>;
+				interrupts = <22>;
+				clocks = <&clks IMX27_CLK_CKIL>,
+					 <&clks IMX27_CLK_RTC_IPG_GATE>;
+				clock-names = "ref", "ipg";
+			};
+
 			kpp: kpp at 10008000 {
 				compatible = "fsl,imx27-kpp", "fsl,imx21-kpp";
 				reg = <0x10008000 0x1000>;
-- 
1.7.4.4
