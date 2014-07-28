From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:06 -0500
Subject: [PATCH 18/35] arm: boot: dts: am33xx/omap3: fix intc compatible flag
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-19-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

that way, our intc driver can figure out how
many IRQ lines INTC has.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 arch/arm/boot/dts/omap3.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..ddaa4ae 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -133,7 +133,7 @@
 		};
 
 		intc: interrupt-controller at 48200000 {
-			compatible = "ti,omap2-intc";
+			compatible = "ti,am33xx-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			ti,intc-size = <128>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b2891a9..b693929 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -140,7 +140,7 @@
 		};
 
 		intc: interrupt-controller at 48200000 {
-			compatible = "ti,omap2-intc";
+			compatible = "ti,omap3-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			ti,intc-size = <96>;
-- 
2.0.1.563.g66f467c
