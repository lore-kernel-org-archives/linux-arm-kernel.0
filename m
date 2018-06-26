From: david@lechnology.com (David Lechner)
Date: Tue, 26 Jun 2018 10:28:17 -0500
Subject: [PATCH] ARM: dts: da850: Add power-domains to PWM nodes
Message-ID: <20180626152817.16803-1-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the power-domains property to both the ECAP and EHRPWM PWM
nodes. Both have drivers that use pm_runtime to enable the clocks, so
they need this property in order to find and enable the clock properly.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index de9a8bea100e..d60198e2ae4e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -532,6 +532,7 @@
 			reg = <0x300000 0x2000>;
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
 			clock-names = "fck", "tbclk";
+			power-domains = <&psc1 17>;
 			status = "disabled";
 		};
 		ehrpwm1: pwm at 302000 {
@@ -541,6 +542,7 @@
 			reg = <0x302000 0x2000>;
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
 			clock-names = "fck", "tbclk";
+			power-domains = <&psc1 17>;
 			status = "disabled";
 		};
 		ecap0: ecap at 306000 {
@@ -550,6 +552,7 @@
 			reg = <0x306000 0x80>;
 			clocks = <&psc1 20>;
 			clock-names = "fck";
+			power-domains = <&psc1 20>;
 			status = "disabled";
 		};
 		ecap1: ecap at 307000 {
@@ -559,6 +562,7 @@
 			reg = <0x307000 0x80>;
 			clocks = <&psc1 20>;
 			clock-names = "fck";
+			power-domains = <&psc1 20>;
 			status = "disabled";
 		};
 		ecap2: ecap at 308000 {
@@ -568,6 +572,7 @@
 			reg = <0x308000 0x80>;
 			clocks = <&psc1 20>;
 			clock-names = "fck";
+			power-domains = <&psc1 20>;
 			status = "disabled";
 		};
 		spi0: spi at 41000 {
-- 
2.17.1
