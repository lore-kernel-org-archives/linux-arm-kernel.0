From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 31 Mar 2015 10:21:22 +1100
Subject: linux-next: manual merge of the arm64 tree with the arm-soc tree
Message-ID: <20150331102122.34db1c6e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Today's linux-next merge of the arm64 tree got a conflict in
arch/arm64/configs/defconfig between commit c4bb799588f6 ("arm64: Add
support for Spreadtrum's Sharkl64 Platform in Kconfig and defconfig")
from the arm-soc tree and commit 475bfd3d67fa ("arm64: defconfig:
updates for 4.1") from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm64/configs/defconfig
index f3c8619f8fe1,e07896c819ef..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -31,9 -31,12 +31,13 @@@ CONFIG_MODULES=
  CONFIG_MODULE_UNLOAD=y
  # CONFIG_BLK_DEV_BSG is not set
  # CONFIG_IOSCHED_DEADLINE is not set
+ CONFIG_ARCH_EXYNOS7=y
  CONFIG_ARCH_FSL_LS2085A=y
  CONFIG_ARCH_MEDIATEK=y
 +CONFIG_ARCH_SPRD=y
+ CONFIG_ARCH_SEATTLE=y
+ CONFIG_ARCH_TEGRA=y
+ CONFIG_ARCH_TEGRA_132_SOC=y
  CONFIG_ARCH_THUNDER=y
  CONFIG_ARCH_VEXPRESS=y
  CONFIG_ARCH_XGENE=y
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/387d21ef/attachment.sig>
