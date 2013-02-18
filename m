From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 18 Feb 2013 16:01:25 +1100
Subject: linux-next: manual merge of the arm-soc tree with the input tree
Message-ID: <20130218160125.0afc414767b236bdfc6ee8df@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/input/keyboard/tegra-kbc.c between commit 9eee07d39fa6 ("Input:
tegra-kbc - require CONFIG_OF, remove platform data") from the input tree
and commit 61fd290d213e ("ARM: tegra: migrate to new clock code") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/input/keyboard/tegra-kbc.c
index d89e7d39,54ac1dc..0000000
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@@ -29,16 -29,9 +29,16 @@@
  #include <linux/of.h>
  #include <linux/clk.h>
  #include <linux/slab.h>
 -#include <linux/input/tegra_kbc.h>
 +#include <linux/input/matrix_keypad.h>
- #include <mach/clk.h>
+ #include <linux/clk/tegra.h>
  
 +#define KBC_MAX_GPIO	24
 +#define KBC_MAX_KPENT	8
 +
 +#define KBC_MAX_ROW	16
 +#define KBC_MAX_COL	8
 +#define KBC_MAX_KEY	(KBC_MAX_ROW * KBC_MAX_COL)
 +
  #define KBC_MAX_DEBOUNCE_CNT	0x3ffu
  
  /* KBC row scan time and delay for beginning the row scan. */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130218/da17d8fa/attachment.sig>
