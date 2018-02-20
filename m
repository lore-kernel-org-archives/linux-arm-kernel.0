From: niklas.cassel@axis.com (Niklas Cassel)
Date: Tue, 20 Feb 2018 18:00:44 +0100
Subject: [PATCH 3/8] ARM: dts: artpec: remove 0x prefix from clkctrl unit
 address
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
Message-ID: <20180220170049.22809-4-niklas.cassel@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove 0x prefix from clkctrl unit address.

This silences the following dtc warning:
Warning (unit_address_format):
 Node /clkctrl at 0xf8000000 unit name should not have leading "0x"

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index d9776a97d8ff..f4b39738f1ac 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -98,7 +98,7 @@
 		clock-frequency = <125000000>;
 	};
 
-	clkctrl: clkctrl at 0xf8000000 {
+	clkctrl: clkctrl at f8000000 {
 		#clock-cells = <1>;
 		compatible = "axis,artpec6-clkctrl";
 		reg = <0xf8000000 0x48>;
-- 
2.14.2
