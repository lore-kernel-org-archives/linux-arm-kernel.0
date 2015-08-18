From: briannorris@chromium.org (Brian Norris)
Date: Tue, 18 Aug 2015 11:44:15 -0700
Subject: [PATCH 2/2] ARM: dts: rockchip: correct regulator PM properties
In-Reply-To: <1439923455-109818-1-git-send-email-briannorris@chromium.org>
References: <1439923455-109818-1-git-send-email-briannorris@chromium.org>
Message-ID: <1439923455-109818-2-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DTS file was submitted with non-upstream bindings. I happened
across this while reviewing the jaq DTS.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
---
Tested on jaq, not minnie

 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 0e30bd6bf92b..6f619c154dc6 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -128,12 +128,16 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-name = "vcc33_touch";
-			regulator-suspend-mem-disabled;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 
 		vcc5v_touch: SWITCH_REG2 {
 			regulator-name = "vcc5v_touch";
-			regulator-suspend-mem-disabled;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 	};
 };
-- 
2.5.0.276.gf5e568e
