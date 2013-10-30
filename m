From: denis@eukrea.com (Denis Carikli)
Date: Wed, 30 Oct 2013 18:58:42 +0100
Subject: [PATCHv8][ 3/4] ARM: dts: cpuimx51 Add touchscreen support.
In-Reply-To: <1383155923-24076-1-git-send-email-denis@eukrea.com>
References: <1383155923-24076-1-git-send-email-denis@eukrea.com>
Message-ID: <1383155923-24076-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v7->v8:
- Added Shawn Guo in the cc list.
---
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
index 8638656..34ca8d3a 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -42,6 +42,17 @@
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	tsc2007: tsc2007 at 49 {
+		compatible = "ti,tsc2007";
+		reg = <0x49>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007_1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <0x0 0x8>;
+		gpios = <&gpio4 0 0>;
+		ti,x-plate-ohms = <180>;
+	};
 };
 
 &iomuxc {
-- 
1.7.9.5
