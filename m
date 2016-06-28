From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 28 Jun 2016 22:11:14 +0200
Subject: [PATCH] ARM: dts: sun7i: Fix pll3x2 and pll7x2 not having a parent
 clock
Message-ID: <1467144674-21322-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix pll3x2 and pll7x2 not having a parent clock, specifically this
fixes the kernel turning of pll3 while simplefb is using it when
uboot has configured things to use pll3x2 as lcd ch clk parent.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 1ae54d1..1146197 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -234,6 +234,7 @@
 		pll3x2: pll3x2_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			clocks = <&pll3>;
 			clock-div = <1>;
 			clock-mult = <2>;
 			clock-output-names = "pll3-2x";
@@ -275,6 +276,7 @@
 		pll7x2: pll7x2_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			clocks = <&pll7>;
 			clock-div = <1>;
 			clock-mult = <2>;
 			clock-output-names = "pll7-2x";
-- 
2.7.4
