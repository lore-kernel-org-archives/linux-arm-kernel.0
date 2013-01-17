From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 17 Jan 2013 11:24:32 +0800
Subject: [PATCH v2 3/3] at91: at91sam9n12: add DT parameters to enable PMECC
In-Reply-To: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
References: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358393072-14794-4-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Default ecc correctable setting is 2bits in 512 bytes.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
change log:
   v2: rebase to v3.8-rc3

 arch/arm/boot/dts/at91sam9n12.dtsi  |    1 +
 arch/arm/boot/dts/at91sam9n12ek.dts |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index e9efb34..eb9f12e 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -366,6 +366,7 @@
 				0xffffe600 0x00000200
 				0x00100000 0x00100000
 			       >;
+			atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
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
