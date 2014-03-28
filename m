From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 28 Mar 2014 14:39:52 +1100
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20140328143952.7a77bc128f4affc3efd48ddf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in
arch/arm/boot/dts/sun7i-a20.dtsi between commit 36ab3e73b7ac ("ARM: dt:
sun7i: Add A20 SPI controller nodes") from the arm-soc tree and commit
8ff973a26763 ("ARM: sun7i/sun6i: dts: Add NMI irqchip support") from the
tip tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/sun7i-a20.dtsi
index 024a01ce4f0c,cadcf2f9881d..000000000000
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@@ -401,28 -339,14 +401,36 @@@
  		#size-cells = <1>;
  		ranges;
  
 +		spi0: spi at 01c05000 {
 +			compatible = "allwinner,sun4i-a10-spi";
 +			reg = <0x01c05000 0x1000>;
 +			interrupts = <0 10 4>;
 +			clocks = <&ahb_gates 20>, <&spi0_clk>;
 +			clock-names = "ahb", "mod";
 +			status = "disabled";
 +			#address-cells = <1>;
 +			#size-cells = <0>;
 +		};
 +
 +		spi1: spi at 01c06000 {
 +			compatible = "allwinner,sun4i-a10-spi";
 +			reg = <0x01c06000 0x1000>;
 +			interrupts = <0 11 4>;
 +			clocks = <&ahb_gates 21>, <&spi1_clk>;
 +			clock-names = "ahb", "mod";
 +			status = "disabled";
 +			#address-cells = <1>;
 +			#size-cells = <0>;
 +		};
 +
+ 		nmi_intc: interrupt-controller at 01c00030 {
+ 			compatible = "allwinner,sun7i-a20-sc-nmi";
+ 			interrupt-controller;
+ 			#interrupt-cells = <2>;
+ 			reg = <0x01c00030 0x0c>;
+ 			interrupts = <0 0 4>;
+ 		};
+ 
  		emac: ethernet at 01c0b000 {
  			compatible = "allwinner,sun4i-a10-emac";
  			reg = <0x01c0b000 0x1000>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/bfb7168e/attachment.sig>
