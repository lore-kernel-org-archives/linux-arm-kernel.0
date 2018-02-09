From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri,  9 Feb 2018 14:28:08 +0530
Subject: [PATCH 08/10] ARM64: dts: meson: Remove "cooling-{min|max}-level" for
 gpio-fan node
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
gpio-fan cooling device is found by referring to the
"gpio-fan,speed-map" instead.

Remove the unused properties from the gpio-fan node.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 658215c9822c..8ee4a693c438 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -59,8 +59,6 @@
 				      1 1
 				      2 2
 				      3 3>;
-		cooling-min-level = <0>;
-		cooling-max-level = <3>;
 		#cooling-cells = <2>;
 	};
 
-- 
2.15.0.194.g9af6a3dea062
