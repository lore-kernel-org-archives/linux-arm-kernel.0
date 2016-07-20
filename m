From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 20 Jul 2016 10:45:01 +1000
Subject: linux-next: manual merge of the fsl tree with the arm-soc tree
Message-ID: <20160720104501.02bd5a2a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

Today's linux-next merge of the fsl tree got a conflict in:

  drivers/soc/Kconfig

between commit:

  34642650e5bc ("soc: Move brcmstb to bcm/brcmstb")

from the arm-soc tree and commit:

  82117b4a8897 ("soc: fsl: add GUTS driver for QorIQ platforms")

from the fsl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc drivers/soc/Kconfig
index fe42a2fdf351,7106463f118e..000000000000
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@@ -1,7 -1,8 +1,7 @@@
  menu "SOC (System On Chip) specific Drivers"
  
  source "drivers/soc/bcm/Kconfig"
- source "drivers/soc/fsl/qe/Kconfig"
 -source "drivers/soc/brcmstb/Kconfig"
+ source "drivers/soc/fsl/Kconfig"
  source "drivers/soc/mediatek/Kconfig"
  source "drivers/soc/qcom/Kconfig"
  source "drivers/soc/rockchip/Kconfig"
