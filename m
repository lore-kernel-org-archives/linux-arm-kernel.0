From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 23 May 2017 12:16:09 -0300
Subject: [PATCH 2/2] ARM: dts: imx7d-pico: Pass 'no-1-8-v' property to the eMMC
In-Reply-To: <1495552569-18567-1-git-send-email-fabio.estevam@nxp.com>
References: <1495552569-18567-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1495552569-18567-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the following eMMC error is seen:

mmc1: mmc_select_hs200 failed, error -74

On imx7d-pico the eMMC VCCQ is fixed at 3.15V, so pass the 'no-1-8-v'
property to properly describe that 1.8V operation is not possible.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-pico.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dts b/arch/arm/boot/dts/imx7d-pico.dts
index f874352..79b5d83 100644
--- a/arch/arm/boot/dts/imx7d-pico.dts
+++ b/arch/arm/boot/dts/imx7d-pico.dts
@@ -279,6 +279,7 @@
 	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
 	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
+	no-1-8-v;
 	fsl,tuning-step = <2>;
 	non-removable;
 	status = "okay";
-- 
2.7.4
