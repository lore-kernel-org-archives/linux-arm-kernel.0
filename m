From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 17 Jan 2013 11:24:31 +0800
Subject: [PATCH v2 2/3] at91: 9x5: add DT parameters to enable PMECC
In-Reply-To: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
References: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358393072-14794-3-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Default ecc correctable setting is 2bits in 512 bytes.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
change log:
   v2: rebase to v3.8-rc3

 arch/arm/boot/dts/at91sam9x5.dtsi   |    4 ++++
 arch/arm/boot/dts/at91sam9x5cm.dtsi |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 40ac3a4..eedc191 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -480,7 +480,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x40000000 0x10000000
+			       0xffffe000 0x600		/* PMECC Registers */
+			       0xffffe600 0x200		/* PMECC Error Location Registers */
+			       0x00100000 0x100000	/* ROM code */
 			      >;
+			atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 31e7be2..4027ac7 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -26,7 +26,10 @@
 	ahb {
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
+			nand-ecc-mode = "hw";
+			atmel,has-pmecc;	/* Enable PMECC */
+			atmel,pmecc-cap = <2>;
+			atmel,pmecc-sector-size = <512>;
 			nand-on-flash-bbt;
 			status = "okay";
 
-- 
1.7.9.5
