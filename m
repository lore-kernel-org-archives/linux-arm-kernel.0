From: srv_hongzhou.yang@mediatek.com (srv_hongzhou.yang at mediatek.com)
Date: Fri, 19 Sep 2014 19:48:25 +0800
Subject: [PATCH 3/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <1411127306-13677-1-git-send-email-srv_hongzhou.yang@mediatek.com>
References: <1411127306-13677-1-git-send-email-srv_hongzhou.yang@mediatek.com>
Message-ID: <1411127306-13677-4-git-send-email-srv_hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hongzhou Yang <hongzhou.yang@mediatek.com>

Add pinctrl node to mt8135.dtsi.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 90a56ad..1bfd3d0 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -15,6 +15,8 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton64.dtsi"
+#include "mt8135-pinfunc.h"
+#include <dt-bindings/pinctrl/mt65xx.h>
 
 / {
 	compatible = "mediatek,mt8135";
@@ -111,5 +113,14 @@
 			      <0 0x10214000 0 0x2000>,
 			      <0 0x10216000 0 0x2000>;
 		};
+
+		pio: pinctrl at 10005000 {
+			compatible = "mediatek,mt8135-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x1020C000 0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 	};
 };
-- 
1.8.1.1.dirty
