From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  4 May 2016 18:43:48 -0300
Subject: [PATCH v2 2/2] ARM: dts: imx6ul-14x14-evk: Pass "fsl,
 sai-mclk-direction-output"
In-Reply-To: <1462398228-24447-1-git-send-email-festevam@gmail.com>
References: <1462398228-24447-1-git-send-email-festevam@gmail.com>
Message-ID: <1462398228-24447-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass "fsl,sai-mclk-direction-output" to the sai2 node, so that the
SAI2_MCLK can be an output.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Drop gpr node
- Use "fsl,sai-mclk-direction-output"

 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 668a729..918c7c8 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -146,6 +146,7 @@
 			  <&clks IMX6UL_CLK_SAI2>;
 	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
 	assigned-clock-rates = <0>, <12288000>;
+	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
 
-- 
1.9.1
