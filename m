From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 20 Dec 2011 14:39:57 +0100
Subject: [PATCH v2 4/5] arm/dts: OMAP3: Add interrupt-controller bindings for
 INTC
In-Reply-To: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Message-ID: <1324388398-2683-5-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the DTS with the proper information required by the
INTC bindings.

- Add the number of interrupt lines
- Add the reg and the compatible entries.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3.dtsi |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d202bb5..6866dc7 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -54,10 +54,12 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
-		intc: interrupt-controller at 1 {
-			compatible = "ti,omap3-intc";
+		intc: interrupt-controller at 48200000 {
+			compatible = "ti,omap2-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
+			ti,intc-size = <96>;
+			reg = <0x48200000 0x1000>;
 		};
 	};
 };
-- 
1.7.0.4
