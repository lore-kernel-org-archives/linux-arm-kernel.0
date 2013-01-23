From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 23 Jan 2013 20:47:10 +0800
Subject: [PATCH 3/5] ARM: at91: at91sam9n12: add DT parameters to enable PMECC
In-Reply-To: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
References: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358945232-2282-4-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Default ecc correctable setting is 2bits in 512 bytes.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi  |    3 ++-
 arch/arm/boot/dts/at91sam9n12ek.dts |    5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 80e29c6..a3a3fdb 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -390,8 +390,9 @@
 			reg = < 0x40000000 0x10000000
 				0xffffe000 0x00000600
 				0xffffe600 0x00000200
-				0x00100000 0x00100000
+				0x00108000 0x00018000
 			       >;
+			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 0376bf4..d400f8d 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -71,7 +71,10 @@
 
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
+			nand-ecc-mode = "hw";
+			atmel,has-pmecc;
+			atmel,pmecc-cap = <2>;
+			atmel,pmecc-sector-size = <512>;
 			nand-on-flash-bbt;
 			status = "okay";
 		};
-- 
1.7.9.5
