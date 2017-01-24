From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:29 +0800
Subject: [PATCH 10/11] arm64: dts: allwinner: Remove no longer used
 pinctrl/sun4i-a10.h header
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-11-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All dts files for the sunxi platform have been switched to the generic
pinconf bindings. As a result, the sunxi specific pinctrl macros are
no longer used.

Remove the #include entry with the following command:

    sed -i -e '/pinctrl\/sun4i-a10.h/D' \
	arch/arm64/boot/dts/allwinner/*.dts?

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 99b6bb1e141c..6ec831177b22 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -44,7 +44,6 @@
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
 
 / {
-- 
2.11.0
