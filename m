From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 31 Aug 2016 10:56:48 -0300
Subject: [PATCH] ARM: dts: imx6qdl: Fix SPDIF regression
Message-ID: <1472651808-28034-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 833f2cbf7091 ("ARM: dts: imx6: change the core clock of spdif")
changed many more clocks than only the SPDIF core clock as stated in
the commit message.

The MLB clock has been added and this causes SPDIF regression as
reported by Xavi Drudis Ferran and also in this forum post:
https://forum.digikey.com/thread/34240

The MX6Q Reference Manual does not mention that MLB is a clock related
to SPDIF, so change it back to a dummy clock to restore SPDIF
functionality.

Thanks to Ambika for providing the fix at:
https://community.nxp.com/thread/387131

Fixes: 833f2cbf7091 ("ARM: dts: imx6: change the core clock of spdif")
Cc: <stable@vger.kernel.org> # 4.4.x
Reported-by: Xavi Drudis Ferran <xdrudis@tinet.cat>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b620ac8..b13b0b2 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -243,7 +243,7 @@
 					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
 						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
 						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
-						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
+						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_DUMMY>,
 						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
 					clock-names = "core",  "rxtx0",
 						      "rxtx1", "rxtx2",
-- 
1.9.1
