From: briannorris@chromium.org (Brian Norris)
Date: Wed, 19 Aug 2015 15:18:40 -0700
Subject: [PATCH v2 2/3] ARM: dts: rockchip: correct regulator PM properties
In-Reply-To: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
References: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
Message-ID: <1440022721-73712-2-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DTS file was submitted with non-upstream bindings. I happened
across this while reviewing the jaq DTS.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
---
Did not test minnie

v1 -> v2:
 - use "off-in-suspend", as that's the equivalent to the downstream
   'regulator-suspend-mem-disabled'

 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 0e30bd6bf92b..8fd8ef2c72da 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -128,12 +128,16 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-name = "vcc33_touch";
-			regulator-suspend-mem-disabled;
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
 		};
 
 		vcc5v_touch: SWITCH_REG2 {
 			regulator-name = "vcc5v_touch";
-			regulator-suspend-mem-disabled;
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
 		};
 	};
 };
-- 
2.5.0.276.gf5e568e
