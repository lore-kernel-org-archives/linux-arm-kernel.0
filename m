From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Nov 2012 15:37:14 +1100
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20121127153714.2da0df11b77fc74601482ef4@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/spear13xx.dtsi between commit 6d7b42a447f9 ("mtd:
fsmc_nand: pass the ale and cmd resource via resource") from the l2-mtd
tree and commit f631b984ee10 ("ARM: SPEAr: DT: Fix existing DT support")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/spear13xx.dtsi
index 701b0d7,009096d..0000000
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@@ -151,6 -125,9 +165,7 @@@
  				      0 21 0x4
  				      0 22 0x4
  				      0 23 0x4>;
 -			st,ale-off = <0x20000>;
 -			st,cle-off = <0x10000>;
+ 			st,mode = <2>;
  			status = "disabled";
  		};
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/1c4adb17/attachment.sig>
