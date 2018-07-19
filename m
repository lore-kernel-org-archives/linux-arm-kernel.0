From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 19 Jul 2018 16:24:19 +0800
Subject: [PATCH] ARM: dts: imx7d: remove "operating-points" property for cpu1
Message-ID: <1531988659-9466-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
added "operating-points" property for all CPUs, but i.MX7D already has
"operating-points-v2" property on both CPUs, so no need to add
"operating-points" property again, this patch removes it.

Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 9a772fc..7cbc2ff 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -18,11 +18,6 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
-			operating-points = <
-				/* KHz	uV */
-				996000	1075000
-				792000	975000
-			>;
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
-- 
2.7.4
