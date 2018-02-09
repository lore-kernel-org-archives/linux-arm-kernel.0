From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri,  9 Feb 2018 14:28:07 +0530
Subject: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level" for
 gpio-fan node
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
gpio-fan cooling device is found by referring to the
"gpio-fan,speed-map" instead.

Remove the unused properties from the gpio-fan node.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 08568ce24d06..727d16eb02d9 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -78,8 +78,6 @@
 		gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
 			<&gpio0 12 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0 0>, <3000 1>, <6000 2>;
-		cooling-min-level = <0>;
-		cooling-max-level = <2>;
 		#cooling-cells = <2>;
 	};
 
-- 
2.15.0.194.g9af6a3dea062
