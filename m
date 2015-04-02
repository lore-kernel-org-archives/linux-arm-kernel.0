From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  2 Apr 2015 16:31:59 +0200
Subject: [PATCH] ARM: tegra: Correct which USB controller has the UTMI pad
 registers
Message-ID: <1427985119-15307-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It should be the first controller, not the second.

This broke USB after 6261b06 ("regulator: Defer lookup of supply to
regulator_get"), because it changed the order in which the controllers
were probed.

The fix for this issue was suggested by Mikko Perttunen.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 arch/arm/boot/dts/tegra124.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index cf01c81..cb786a9 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -838,6 +838,7 @@
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,has-utmi-pad-registers;
 		status = "disabled";
 	};
 
@@ -874,7 +875,6 @@
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
-		nvidia,has-utmi-pad-registers;
 		status = "disabled";
 	};
 
-- 
2.3.4
