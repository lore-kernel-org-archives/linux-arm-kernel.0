From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 8 Feb 2017 12:34:15 +1100
Subject: linux-next: manual merge of the kspp tree with the arm-soc tree
Message-ID: <20170208123415.35b5425d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

Today's linux-next merge of the kspp tree got a conflict in:

  arch/arm/configs/aspeed_g5_defconfig

between commit:

  0e81eb77f5f8 ("ARM: configs: Update Aspeed with new drivers")

from the arm-soc tree and commit:

  0f5bf6d0afe4 ("arch: Rename CONFIG_DEBUG_RODATA and CONFIG_DEBUG_MODULE_RONX")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/aspeed_g5_defconfig
index ae4295ec5c3e,05a16d53d03c..000000000000
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@@ -26,8 -26,6 +26,7 @@@ CONFIG_ARCH_MULTI_V6=
  # CONFIG_ARCH_MULTI_V7 is not set
  CONFIG_ARCH_ASPEED=y
  CONFIG_MACH_ASPEED_G5=y
- CONFIG_DEBUG_RODATA=y
 +CONFIG_VMSPLIT_2G=y
  CONFIG_AEABI=y
  CONFIG_UACCESS_WITH_MEMCPY=y
  CONFIG_SECCOMP=y
@@@ -116,8 -80,8 +115,9 @@@ CONFIG_DEBUG_LL_UART_8250=
  CONFIG_DEBUG_UART_PHYS=0x1e784000
  CONFIG_DEBUG_UART_VIRT=0xe8784000
  CONFIG_EARLY_PRINTK=y
- CONFIG_DEBUG_SET_MODULE_RONX=y
+ CONFIG_STRICT_MODULE_RWX=y
+ CONFIG_STRICT_KERNEL_RWX=y
 +CONFIG_CRYPTO_ECHAINIV=y
  # CONFIG_XZ_DEC_X86 is not set
  # CONFIG_XZ_DEC_POWERPC is not set
  # CONFIG_XZ_DEC_IA64 is not set
