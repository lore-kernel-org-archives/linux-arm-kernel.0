From: b20788@freescale.com (Anson Huang)
Date: Wed, 12 Feb 2014 15:56:16 +0800
Subject: [PATCH 1/2] ARM: dts: imx6q: add 852MHz setpoint for CPU freq
Message-ID: <1392191777-15703-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to datasheet, i.MX6Q has setpoint of 852MHz
which is exclusive with 996MHz, the fuse map of speed_grading
defines the max speed of ARM, here we add this 852MHz
setpoint opp info, kernel will check the speed_grading
fuse and remove all illegal setpoints.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 422d169..fadf498 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -30,6 +30,7 @@
 				/* kHz    uV */
 				1200000 1275000
 				996000  1250000
+				852000  1250000
 				792000  1150000
 				396000  975000
 			>;
@@ -37,6 +38,7 @@
 				/* ARM kHz  SOC-PU uV */
 				1200000 1275000
 				996000	1250000
+				852000	1250000
 				792000	1175000
 				396000	1175000
 			>;
-- 
1.7.9.5
