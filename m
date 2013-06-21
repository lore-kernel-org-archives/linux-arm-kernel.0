From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 15:58:46 +1000
Subject: linux-next: manual merge of the arm-soc tree with the net-next tree
Message-ID: <20130621155846.71c2d64923a1e505c08eca72@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/sun4i-a10.dtsi between commit b21da664120b ("ARM:
sun4i: Add muxing options for the ethernet controller") from the net-next
tree and commit 27cce4ff34ec ("ARM: sun4i: dt: Add i2c muxing options")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/sun4i-a10.dtsi
index 983da33,82e03d2..0000000
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@@ -214,18 -204,28 +220,39 @@@
  				allwinner,function = "uart1";
  				allwinner,drive = <0>;
  				allwinner,pull = <0>;
 +			};
 +
 +			emac_pins_a: emac0 at 0 {
 +				allwinner,pins = "PA0", "PA1", "PA2",
 +						"PA3", "PA4", "PA5", "PA6",
 +						"PA7", "PA8", "PA9", "PA10",
 +						"PA11", "PA12", "PA13", "PA14",
 +						"PA15", "PA16";
 +				allwinner,function = "emac";
 +				allwinner,drive = <0>;
 +				allwinner,pull = <0>;
  			};
+ 
+ 			i2c0_pins_a: i2c0 at 0 {
+ 				allwinner,pins = "PB0", "PB1";
+ 				allwinner,function = "i2c0";
+ 				allwinner,drive = <0>;
+ 				allwinner,pull = <0>;
+ 			};
+ 
+ 			i2c1_pins_a: i2c1 at 0 {
+ 				allwinner,pins = "PB18", "PB19";
+ 				allwinner,function = "i2c1";
+ 				allwinner,drive = <0>;
+ 				allwinner,pull = <0>;
+ 			};
+ 
+ 			i2c2_pins_a: i2c2 at 0 {
+ 				allwinner,pins = "PB20", "PB21";
+ 				allwinner,function = "i2c2";
+ 				allwinner,drive = <0>;
+ 				allwinner,pull = <0>;
+ 			};
  		};
  
  		timer at 01c20c00 {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/b83c7c1f/attachment.sig>
