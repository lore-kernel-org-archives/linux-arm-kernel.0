From: denis@eukrea.com (Denis Carikli)
Date: Mon,  4 Nov 2013 17:15:23 +0100
Subject: [PATCHv4][ 5/6] ARM: dts: i.MX35: Add display support.
In-Reply-To: <1383581724-14817-1-git-send-email-denis@eukrea.com>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
Message-ID: <1383581724-14817-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev at vger.kernel.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v3->v4:
- Splitted the imx35.dtsi display support (new patch).
---
 arch/arm/boot/dts/imx35.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 0f67f22..9a46146 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -349,6 +349,22 @@
 				status = "disabled";
 			};
 
+			ipu: ipu at 53fc0000 {
+				compatible = "fsl,imx31-ipu";
+				reg = <	0x53fc0000 0x5f
+					0x53fc0088 0x2b >;
+				interrupts = <42 41>;
+				clocks = <&clks 55>;
+				status = "disabled";
+			};
+
+			lcdc: mx3fb at 53fc00b4 {
+				compatible = "fsl,mx3-fb";
+				reg = <0x53fc00b4 0x0b>;
+				clocks = <&clks 55>;
+				status = "disabled";
+			};
+
 			audmux: audmux at 53fc4000 {
 				compatible = "fsl,imx35-audmux", "fsl,imx31-audmux";
 				reg = <0x53fc4000 0x4000>;
-- 
1.7.9.5
