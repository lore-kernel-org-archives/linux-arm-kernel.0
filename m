From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue,  4 Aug 2015 23:08:01 +0200
Subject: [PATCH v2] ARM: dts: sunxi: Raise minimum CPU voltage for sun7i-a20
 to meet SoC specifications
Message-ID: <1438722481-2302-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun7i-a20.dtsi contains a cpufreq operating point at 0.9 volts. The minimum
CPU voltage for the Allwinner A20 SoC, however, is 1.0 volts. Thus, raise
the voltage for the lowest operating point to 1.0 volts in order to stay
within the SoC specifications. It is an undervolted setting that isn't
stable across all SoCs and boards out there.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
Changes since v1:

- Fixed checkpatch warnings
- Changed the commit message and title to clarify that this is not a board-specific issue, but rather a limitation by the SoC  
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
