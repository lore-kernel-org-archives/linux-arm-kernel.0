From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Apr 2016 16:38:48 -0300
Subject: [PATCH 2/2] ARM: dts: imx6sx: Add 198MHz operating point
In-Reply-To: <1461613128-24001-1-git-send-email-festevam@gmail.com>
References: <1461613128-24001-1-git-send-email-festevam@gmail.com>
Message-ID: <1461613128-24001-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

198MHz is a valid operating point for mx6sx.

Add entries for VDD_ARM_CAP and VDD_SOC_CAP voltages for 198MHz according
to the imx6sx datahseet:
http://cache.nxp.com/files/32bit/doc/data_sheet/IMX6SXIEC.pdf

(a 25mV offset is added to the minimum allowed values for safety).

These values also match the ones from the NXP kernel.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index d02ab32..6a993bfda 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -63,12 +63,14 @@
 				996000  1250000
 				792000  1175000
 				396000  1075000
+				198000	975000
 			>;
 			fsl,soc-operating-points = <
 				/* ARM kHz  SOC uV */
 				996000      1175000
 				792000      1175000
 				396000      1175000
+				198000	    1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX6SX_CLK_ARM>,
-- 
1.9.1
