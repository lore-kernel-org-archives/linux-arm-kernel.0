From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Dec 2016 11:13:59 +1100
Subject: linux-next: manual merge of the sunxi tree with the arm-soc tree
Message-ID: <20161208111359.7d201b0f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Today's linux-next merge of the sunxi tree got a conflict in:

  arch/arm/boot/dts/sun8i-h3.dtsi

between commit:

  4367c1d84655 ("dts: sun8i-h3: correct UART3 pin definitions")

from the arm-soc tree and commits:

  acac77949d26 ("ARM: sunxi: Remove useless allwinner,drive property")
  3872abae96ef ("ARM: sunxi: Remove useless allwinner,pull property")
  264969c22623 ("ARM: sunxi: Convert pinctrl nodes to generic bindings")

from the sunxi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/boot/dts/sun8i-h3.dtsi
index 6c14a6f72820,fca66bf2dec5..000000000000
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@@ -425,10 -406,8 +406,8 @@@
  			};
  
  			uart3_pins: uart3 {
- 				allwinner,pins = "PA13", "PA14";
- 				allwinner,function = "uart3";
- 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
- 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 -				pins = "PG13", "PG14";
++				pins = "PA13", "PA14";
+ 				function = "uart3";
  			};
  		};
  
