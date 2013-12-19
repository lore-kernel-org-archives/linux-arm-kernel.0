From: b20788@freescale.com (Anson Huang)
Date: Thu, 19 Dec 2013 09:16:48 -0500
Subject: [PATCH V4 2/3] ARM: imx: add vddsoc/pu setpoint info into dts
In-Reply-To: <1387462609-13013-1-git-send-email-b20788@freescale.com>
References: <1387462609-13013-1-git-send-email-b20788@freescale.com>
Message-ID: <1387462609-13013-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6Q needs to update vddarm, vddsoc/pu regulators when cpu freq
is changed, each setpoint has different voltage, so we need to
pass vddarm, vddsoc/pu's freq-voltage info from dts together.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e7e8332..021e0cb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -30,6 +30,13 @@
 				792000  1150000
 				396000  975000
 			>;
+			fsl,soc-operating-points = <
+				/* ARM kHz  SOC-PU uV */
+				1200000 1275000
+				996000	1250000
+				792000	1175000
+				396000	1175000
+			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
 				 <&clks 17>, <&clks 170>;
-- 
1.7.9.5
