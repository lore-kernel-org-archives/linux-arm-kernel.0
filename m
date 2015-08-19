From: briannorris@chromium.org (Brian Norris)
Date: Wed, 19 Aug 2015 15:18:41 -0700
Subject: [PATCH v2 3/3] ARM: dts: rockchip: correct regulator power states for
 suspend
In-Reply-To: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
References: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
Message-ID: <1440022721-73712-3-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When getting translated from a downstream device tree that used slightly
different DT bindings, these regulators got labeled with the
"on-in-suspend" state, when they were actually supposed to be turned off
for S3 suspend. This was harmless, but not intentional, AFAICT.

Let's turn them off to get the optimal power state.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
---
New in v2. Tested jaq.

 arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 2 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts  | 2 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index 42d724559915..60bd6e91e308 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -99,7 +99,7 @@
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-state-mem {
-				regulator-on-in-suspend;
+				regulator-off-in-suspend;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index 25eb4b0c1330..94b56e33d947 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -109,7 +109,7 @@
 			regulator-boot-on;
 			regulator-name = "vcc18_lcd";
 			regulator-state-mem {
-				regulator-on-in-suspend;
+				regulator-off-in-suspend;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
index 788468a48163..b5334ecff13c 100644
--- a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
@@ -93,7 +93,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-state-mem {
-				regulator-on-in-suspend;
+				regulator-off-in-suspend;
 			};
 		};
 
@@ -102,7 +102,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-state-mem {
-				regulator-on-in-suspend;
+				regulator-off-in-suspend;
 			};
 		};
 	};
-- 
2.5.0.276.gf5e568e
