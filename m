From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 14 May 2017 11:50:50 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-wandboard: Fix audio channel swap
Message-ID: <1494773451-11111-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

When running a stress playback/stop loop test on a mx6wandboard channel
swaps can be noticed randomly.

Increasing the SGTL5000 LRCLK pad strength to its maximum value fixes
the issue, so add the 'lrclk-strength' property to avoid the audio
channel swaps.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 82dc5744..850cead 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -88,6 +88,7 @@
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
+		lrclk-strength = <3>;
 	};
 };
 
-- 
2.7.4
