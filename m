From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 21:38:53 +1100
Subject: linux-next: manual merge of the arm-soc tree with the mmc tree
Message-ID: <20121126213853.ccceb25dc3b3c5a24911abef@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
include/linux/platform_data/mmc-omap.h between commit 69bc0b677e6c ("mmc:
omap_hsmmc: Enable HSPE bit for high speed cards") from the  tree and
commit 53db20d123f7 ("mmc: omap: Remove cpu_is_omap usage from the
driver") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc include/linux/platform_data/mmc-omap.h
index 346af5b,2bf6ea8..0000000
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@@ -126,7 -107,9 +107,10 @@@ struct omap_mmc_platform_data 
  		/* we can put the features above into this variable */
  #define HSMMC_HAS_PBIAS		(1 << 0)
  #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
 -#define MMC_OMAP7XX		(1 << 2)
 -#define MMC_OMAP15XX		(1 << 3)
 -#define MMC_OMAP16XX		(1 << 4)
 +#define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
++#define MMC_OMAP7XX		(1 << 3)
++#define MMC_OMAP15XX		(1 << 4)
++#define MMC_OMAP16XX		(1 << 5)
  		unsigned features;
  
  		int switch_pin;			/* gpio (card detect) */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/815f3fba/attachment.sig>
