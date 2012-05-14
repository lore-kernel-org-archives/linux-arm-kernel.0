From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 May 2012 19:24:04 +1000
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
Message-ID: <20120514192404.91f9477851ad8485a2112973@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in
drivers/clk/Kconfig between commit d269b974e32c ("clk: remove
COMMON_CLK_DISABLE_UNUSED") from the arm-soc tree and commit "clk: remove
redundant depends on from drivers/Kconfig" from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clk/Kconfig
index 4864407,4f10a21..0000000
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@@ -23,9 -22,18 +23,8 @@@ config COMMON_CL
  menu "Common Clock Framework"
  	depends on COMMON_CLK
  
 -config COMMON_CLK_DISABLE_UNUSED
 -	bool "Disabled unused clocks at boot"
 -	---help---
 -	  Traverses the entire clock tree and disables any clocks that are
 -	  enabled in hardware but have not been enabled by any device drivers.
 -	  This saves power and keeps the software model of the clock in line
 -	  with reality.
 -
 -	  If in doubt, say "N".
 -
  config COMMON_CLK_DEBUG
  	bool "DebugFS representation of clock tree"
- 	depends on COMMON_CLK
  	select DEBUG_FS
  	---help---
  	  Creates a directory hierchy in debugfs for visualizing the clk
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/b535ead0/attachment.sig>
