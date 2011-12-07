From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 7 Dec 2011 21:50:46 +0100
Subject: [PATCH 1/4] arm/dts: OMAP4: Update DTS file with new GIC bindings
In-Reply-To: <1323291049-24964-1-git-send-email-b-cousson@ti.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com>
Message-ID: <1323291049-24964-2-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC binding was updated in 3.2 and expect 3 interrupt-cells.
- Update the #interrupt-cells
- interrupt-parent seems to be needed as well for the top level GIC

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..bede009 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -95,7 +95,8 @@
 		gic: interrupt-controller at 48241000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			interrupt-parent;
+			#interrupt-cells = <3>;
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
-- 
1.7.0.4
