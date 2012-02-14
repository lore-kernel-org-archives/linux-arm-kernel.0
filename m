From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 14 Feb 2012 18:56:11 +0100
Subject: [PATCH v3 3/4] arm/dts: OMAP3: Add interrupt-controller bindings for
 INTC
In-Reply-To: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Message-ID: <1329242172-4214-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the DTS with the proper information required by the
INTC bindings.

- Add the number of interrupt lines
- Add the reg and the compatible entries.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap3.dtsi |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 216c331..34cce6d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -61,10 +61,12 @@
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
 
 		uart1: serial at 0x4806a000 {
-- 
1.7.0.4
