From: andreas.henriksson@endian.se (Andreas Henriksson)
Date: Tue, 23 Sep 2014 17:12:52 +0200
Subject: [PATCH v2] ARM: at91: fix at91sam9263ek DT mmc pinmuxing settings
In-Reply-To: <5421623D.6090609@atmel.com>
References: <5421623D.6090609@atmel.com>
Message-ID: <1411485172-7984-1-git-send-email-andreas.henriksson@endian.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discovered on a custom board similar to at91sam9263ek and basing
its devicetree on that one apparently the pin muxing doesn't get
set up properly. This was discovered since the custom boards u-boot
does funky stuff with the pin muxing and leaved it set to SPI
which made the MMC driver not work under Linux.
The fix is simply to define the given configuration as the default.
This probably worked by pure luck before, but it's better to
make the muxing explicitly set.

CC: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Andreas Henriksson <andreas.henriksson@endian.se>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 2 ++
 1 file changed, 2 insertions(+)

v2: put pinctrl-names in dtsi instead as requested/suggested by Nicolas Ferre


diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index bb23c2d..5e95a80 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -834,6 +834,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xfff80000 0x600>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&mci0_clk>;
@@ -845,6 +846,7 @@
 				compatible = "atmel,hsmci";
 				reg = <0xfff84000 0x600>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&mci1_clk>;
-- 
2.1.0
