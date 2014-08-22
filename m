From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 09:03:51 -0500
Subject: [PATCH 2/6] ARM: dts: OMAP5: switch to compatible pinctrl
In-Reply-To: <1408716235-26164-1-git-send-email-nm@ti.com>
References: <1408716235-26164-1-git-send-email-nm@ti.com>
Message-ID: <1408716235-26164-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ti,omap5-padconf is available, switch over to that compatible
property. Retain pinctrl-single for legacy support.

While at it, mark pinctrl as interrupt controller so that it can be
used with interrupts-extended property for wakeup events.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index df0a09b..04acda6 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -188,18 +188,22 @@
 		};
 
 		omap5_pmx_core: pinmux at 4a002840 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap5-padconf", "pinctrl-single";
 			reg = <0x4a002840 0x01b6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 		omap5_pmx_wkup: pinmux at 4ae0c840 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap5-padconf", "pinctrl-single";
 			reg = <0x4ae0c840 0x0038>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0x7fff>;
 		};
-- 
1.7.9.5
