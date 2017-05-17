From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 17 May 2017 15:55:25 -0300
Subject: [PATCH] ARM: dts: imx7s-warp: Pass 'no-1-8-v' property to the eMMC
Message-ID: <1495047325-6010-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the following eMMC error is seen:

mmc1: mmc_select_hs200 failed, error -74
mmc1: new MMC card at address 0001
mmcblk1: mmc1:0001 V10008 7.05 GiB
mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB

On imx7s-warp the eMMC VCCQ is fixed at 3.15V, so pass the 'no-1-8-v'
property to properly describe that 1.8V operation is not possible.

With this change HS200 error is gone and another benefit is that the
card can operate in DDR52 mode now:

mmc1: new DDR MMC card at address 0001
mmcblk1: mmc1:0001 V10008 7.05 GiB
mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB
mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB
mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB

Suggested-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index d5237fd..8dfed85 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -295,6 +295,7 @@
 	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
 	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
+	no-1-8-v;
 	fsl,tuning-step = <2>;
 	non-removable;
 	status = "okay";
-- 
2.7.4
