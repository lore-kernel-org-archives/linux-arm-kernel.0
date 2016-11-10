From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 01:09:52 +0100
Subject: [PATCH 06/14] ARM: dts: armada-375: Fixup sa-ram DT warning
In-Reply-To: <20161110001000.10619-1-gregory.clement@free-electrons.com>
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
Message-ID: <20161110001000.10619-7-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa-sram which is a mmio-sram has a reg property so the unit name should
contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 390575b2142c..c832ebb40ac4 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -635,7 +635,7 @@
 
 		};
 
-		crypto_sram0: sa-sram0 {
+		crypto_sram0: sa-sram0 at 0 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;
 			clocks = <&gateclk 30>;
@@ -644,7 +644,7 @@
 			ranges = <0 MBUS_ID(0x09, 0x09) 0 0x800>;
 		};
 
-		crypto_sram1: sa-sram1 {
+		crypto_sram1: sa-sram1 at 0 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;
 			clocks = <&gateclk 31>;
-- 
2.10.1
