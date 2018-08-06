From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon,  6 Aug 2018 13:40:05 +0800
Subject: [PATCH] ARM: dts: imx7s: remove snvs_poweroff node
Message-ID: <1533534005-18736-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System poweroff is already supported by PSCI on i.MX7D,
remove "snvs_poweroff" node to avoid below debug message
from syscon-poweroff driver:

[    1.831414] syscon-poweroff 30370000.snvs:snvs-poweroff: pm_power_off already claimed (ptrval) psci_sys_poweroff
[    1.841707] syscon-poweroff: probe of 30370000.snvs:snvs-poweroff failed with error -16

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198..a072e7f 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -563,14 +563,6 @@
 					clock-names = "snvs-rtc";
 				};
 
-				snvs_poweroff: snvs-poweroff {
-					compatible = "syscon-poweroff";
-					regmap = <&snvs>;
-					offset = <0x38>;
-					value = <0x60>;
-					mask = <0x60>;
-				};
-
 				snvs_pwrkey: snvs-powerkey {
 					compatible = "fsl,sec-v4.0-pwrkey";
 					regmap = <&snvs>;
-- 
2.7.4
