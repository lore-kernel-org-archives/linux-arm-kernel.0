From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Mar 2018 15:29:29 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul-isiot: Pass the required
 '#sound-dai-cells'
In-Reply-To: <1521138569-8125-1-git-send-email-festevam@gmail.com>
References: <1521138569-8125-1-git-send-email-festevam@gmail.com>
Message-ID: <1521138569-8125-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

DTC now warns about missing #sound-dai-cells:
    
/sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in
node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle
(referred from sound-dai[0])

Pass the required '#sound-dai-cells' property to fix it.

Reported-by: Arnd Bergmann <arnd@arndb.de> 
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-isiot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index b0ecebb..921e12c 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -142,6 +142,7 @@
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		clocks = <&clks IMX6UL_CLK_OSC>;
 		clock-names = "mclk";
 		VDDA-supply = <&reg_3p3v>;
-- 
2.7.4
