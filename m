From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Mon, 18 May 2015 23:11:21 -0700
Subject: [PATCH v2 10/11] arm64: dts: mt8173-evb: Add pinctrl/GPIO node for
 mt6397.
In-Reply-To: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1432015882-8646-11-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl and GPIO node to mt8173-evb.dts.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index c9bc71b..bd473c8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include "mt8173.dtsi"
+#include <dt-bindings/pinctrl/mt6397-pinfunc.h>
 
 / {
 	model = "mediatek,mt8173-evb";
@@ -43,6 +44,13 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		pio6397: pinctrl at c000 {
+			compatible = "mediatek,mt6397-pinctrl";
+			pins-are-numbered;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		rtc: rtc at e000 {
 			compatible = "mediatek,mt6397-rtc";
 		};
-- 
1.7.9.5
