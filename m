From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Oct 2017 12:05:30 +0000
Subject: linux-next: manual merge of the keystone tree with the arm-soc tree
Message-ID: <20171030120530.rmyan374grqenqyj@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Today's linux-next merge of the keystone tree got a conflict in:

  arch/arm/boot/dts/keystone-k2g.dtsi

between commit:

  8dccafaa281aa1d24 ("arm: dts: fix unit-address leading 0s")

from the arm-soc tree and various commits from the keystone tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm/boot/dts/keystone-k2g.dtsi
index a1ae69d712f7,6f3521d18125..000000000000
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@@ -133,7 -136,40 +136,40 @@@
  			clocks = <&k2g_clks 0x0009 1>;
  		};
  
+ 		i2c0: i2c at 2530000 {
+ 			compatible = "ti,keystone-i2c";
+ 			reg = <0x02530000 0x400>;
+ 			clocks = <&k2g_clks 0x003a 0>;
+ 			power-domains = <&k2g_pds 0x003a>;
+ 			interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			status = "disabled";
+ 		};
+ 
+ 		i2c1: i2c at 2530400 {
+ 			compatible = "ti,keystone-i2c";
+ 			reg = <0x02530400 0x400>;
+ 			clocks = <&k2g_clks 0x003b 0>;
+ 			power-domains = <&k2g_pds 0x003b>;
+ 			interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			status = "disabled";
+ 		};
+ 
+ 		i2c2: i2c at 2530800 {
+ 			compatible = "ti,keystone-i2c";
+ 			reg = <0x02530800 0x400>;
+ 			clocks = <&k2g_clks 0x003c 0>;
+ 			power-domains = <&k2g_pds 0x003c>;
+ 			interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			status = "disabled";
+ 		};
+ 
 -		kirq0: keystone_irq at 026202a0 {
 +		kirq0: keystone_irq at 26202a0 {
  			compatible = "ti,keystone-irq";
  			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>;
  			interrupt-controller;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171030/11bb44c0/attachment.sig>
