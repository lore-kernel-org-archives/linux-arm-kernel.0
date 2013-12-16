From: b20788@freescale.com (Anson Huang)
Date: Mon, 16 Dec 2013 16:07:37 -0500
Subject: [PATCH 1/4] ARM: imx: update i.MX6Q dts setting of VDDARM_CAP voltage
Message-ID: <1387228057-349-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to datasheet, VDD_CACHE_CAP must not exceed VDDARM_CAP
by more than 200mV, as all of i.MX6Q boards' VDD_CACHE_CAP currently
are connected to VDDSOC_CAP, so we need to follow this rule by
increasing VDDARM_CAP's voltage.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 101c434..e7e8332 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -28,7 +28,7 @@
 				1200000 1275000
 				996000  1250000
 				792000  1150000
-				396000  950000
+				396000  975000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
-- 
1.7.9.5
