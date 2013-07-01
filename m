From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 1 Jul 2013 16:28:12 +1000
Subject: linux-next: manual merge of the arm-soc tree with the net-next tree
Message-ID: <20130701162812.def47813e7d94c27950f3e82@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-mxs/mach-mxs.c between commit b7c4114b07bb ("can: flexcan:
Use a regulator to control the CAN transceiver") from the net-next tree
and commit 2046338dcbc6 ("ARM: mxs: Use soc bus infrastructure") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mxs/mach-mxs.c
index 97b8a44,7fa611c..0000000
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@@ -323,13 -477,14 +432,14 @@@ static void __init mxs_machine_init(voi
  		imx28_evk_init();
  	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
  		apx4devkit_init();
- 	else if (of_machine_is_compatible("crystalfontz,cfa10037"))
- 		cfa10037_init();
- 	else if (of_machine_is_compatible("crystalfontz,cfa10049"))
- 		cfa10049_init();
+ 	else if (of_machine_is_compatible("crystalfontz,cfa10037") ||
+ 		 of_machine_is_compatible("crystalfontz,cfa10049") ||
+ 		 of_machine_is_compatible("crystalfontz,cfa10055") ||
+ 		 of_machine_is_compatible("crystalfontz,cfa10057"))
+ 		crystalfontz_init();
  
  	of_platform_populate(NULL, of_default_bus_match_table,
- 			     NULL, NULL);
 -			     mxs_auxdata_lookup, parent);
++			     NULL, parent);
  
  	if (of_machine_is_compatible("karo,tx28"))
  		tx28_post_init();
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/20d169de/attachment.sig>
