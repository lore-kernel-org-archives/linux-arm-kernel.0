From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  3 May 2016 22:12:01 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul-14x14-evk: Enable SAI2_MCLK
In-Reply-To: <1462324321-11060-1-git-send-email-festevam@gmail.com>
References: <1462324321-11060-1-git-send-email-festevam@gmail.com>
Message-ID: <1462324321-11060-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass the "gpr" and "fsl,sai-enable-mclk" to the sai2 node, so that
we can enable the SAI2_MCLK.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 668a729..21c66bb 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -146,6 +146,8 @@
 			  <&clks IMX6UL_CLK_SAI2>;
 	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
 	assigned-clock-rates = <0>, <12288000>;
+	gpr = <&gpr>;
+	fsl,sai-enable-mclk;
 	status = "okay";
 };
 
-- 
1.9.1
