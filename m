From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 16 Dec 2013 10:47:38 +1100
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
Message-ID: <20131216104738.6f845aabd0e3b609ed9ca170@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got a conflict in
drivers/clk/Makefile between commit 0ad6125b1579 ("clk: at91: add PMC
base support") from the arm-soc tree and commit 10cdfe9f327a ("clk:
shmobile: Add R-Car Gen2 clocks support") from the renesas tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clk/Makefile
index ace7309c4369,8dd1339be98b..000000000000
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@@ -35,7 -35,7 +35,8 @@@ obj-$(CONFIG_ARCH_TEGRA)	+= tegra
  obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
  obj-$(CONFIG_COMMON_CLK_XGENE)  += clk-xgene.o
  obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 +obj-$(CONFIG_COMMON_CLK_AT91)	+= at91/
+ obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
  
  obj-$(CONFIG_X86)		+= x86/
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/5384b4b3/attachment-0001.sig>
