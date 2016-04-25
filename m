From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Apr 2016 17:37:17 -0300
Subject: [PATCH] ARM: dts: imx6dl: Fix the VDD_ARM_CAP voltage for 396MHz
 operation
Message-ID: <1461616637-24717-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Table 8 from MX6DL datasheet (IMX6SDLCEC Rev. 5, 06/2015):
http://cache.nxp.com/files/32bit/doc/data_sheet/IMX6SDLCEC.pdf

states the following:

"LDO Output Set Point (VDD_ARM_CAP) = 1.125 V minimum for operation
up to 396 MHz."

So fix the entry by adding the 25mV margin value as done in the other
entries of the table, which results in 1.15V for 396MHz operation.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index c13a73a..9a4c22c 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -30,7 +30,7 @@
 				/* kHz    uV */
 				996000  1250000
 				792000  1175000
-				396000  1075000
+				396000  1150000
 			>;
 			fsl,soc-operating-points = <
 				/* ARM kHz  SOC-PU uV */
-- 
1.9.1
