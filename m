From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 10 Apr 2017 13:18:51 +1000
Subject: linux-next: manual merge of the clockevents tree with the arm-soc tree
Message-ID: <20170410131851.556bc24f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Today's linux-next merge of the clockevents tree got a conflict in:

  arch/arm/boot/dts/rk3188.dtsi

between commit:

  2e1aa605fadd ("ARM: dts: rockchip: fix PPI misconfiguration on Cortex-A9 socs")

from the arm-soc tree and commit:

  500d0aa918a2 ("ARM: dts: rockchip: disable arm-global-timer for rk3188")

from the clockevents tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/boot/dts/rk3188.dtsi
index fa1bdb8875ae,1aff4ad22fc4..000000000000
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@@ -529,7 -545,8 +545,8 @@@
  };
  
  &global_timer {
 -	interrupts = <GIC_PPI 11 0xf04>;
 +	interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+ 	status = "disabled";
  };
  
  &local_timer {
