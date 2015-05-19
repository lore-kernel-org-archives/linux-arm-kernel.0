From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Mon, 18 May 2015 23:11:22 -0700
Subject: [PATCH v2 11/11] ARM: dts: mt8135-evbp1: Add pinctrl/GPIO node for
 mt6397.
In-Reply-To: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1432015882-8646-12-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl and GPIO node to mt8135-evbp1.dts.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 arch/arm/boot/dts/mt8135-evbp1.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
index 357a91f..332233b 100644
--- a/arch/arm/boot/dts/mt8135-evbp1.dts
+++ b/arch/arm/boot/dts/mt8135-evbp1.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include "mt8135.dtsi"
+#include <dt-bindings/pinctrl/mt6397-pinfunc.h>
 
 / {
 	model = "MediaTek MT8135 evaluation board";
@@ -28,6 +29,13 @@
 	pmic: mt6397 {
 		compatible = "mediatek,mt6397";
 
+		pio6397: pinctrl at c000 {
+			compatible = "mediatek,mt6397-pinctrl";
+			pins-are-numbered;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		mt6397regulator: mt6397regulator {
 			compatible = "mediatek,mt6397-regulator";
 
-- 
1.7.9.5
