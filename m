From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Wed, 26 Jul 2017 14:05:32 +0200
Subject: [PATCH v5 2/4] ARM: dts: imx53: add srtc node
In-Reply-To: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
References: <20170726120534.5516-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170726120534.5516-3-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

The i.MX53 has an integrated secure real time clock. Add it to the dtsi.

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
---
 arch/arm/boot/dts/imx53.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 2e516f4985e4..8bf0d89cdd35 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -433,6 +433,15 @@
 				clock-names = "ipg", "per";
 			};
 
+			srtc: srtc at 53fa4000 {
+				compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
+				reg = <0x53fa4000 0x4000>;
+				interrupts = <24>;
+				interrupt-parent = <&tzic>;
+				clocks = <&clks IMX5_CLK_SRTC_GATE>;
+				clock-names = "ipg";
+			};
+
 			iomuxc: iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc";
 				reg = <0x53fa8000 0x4000>;
-- 
2.11.0
