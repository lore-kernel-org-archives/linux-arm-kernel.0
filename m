From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Sun,  2 Aug 2015 21:23:06 +0200
Subject: [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage for sun7i-a20 to a
 level all boards can supply
Message-ID: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20 boards
(or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
voltage for the lowest operating point to 1.0V so all boards can actually use
it.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6a63f30..f5f384c 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -107,7 +107,7 @@
 				720000	1200000
 				528000	1100000
 				312000	1000000
-				144000	900000
+				144000	1000000
 				>;
 			#cooling-cells = <2>;
 			cooling-min-level = <0>;
-- 
2.1.4
