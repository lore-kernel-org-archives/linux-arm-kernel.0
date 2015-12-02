From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Dec 2015 11:21:09 +0000
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
Message-ID: <20151202112109.342837c08019e632b28020fc@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got a conflict in
arch/arm/mach-shmobile/Kconfig between commit e32465429490 ("ARM: use "depends
on" for SoC configs instead of "if" after prompt") from the arm-soc tree and
commit 9b5ba0df4ea4f94 ("ARM: shmobile: Introduce ARCH_RENESAS") from the
renesas tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

diff --cc arch/arm/mach-shmobile/Kconfig
index 0f25f8fa2692,4ed72b124235..000000000000
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@@ -29,10 -31,11 +31,11 @@@ config ARCH_RMOBIL
        select SYS_SUPPORTS_SH_CMT
        select SYS_SUPPORTS_SH_TMU
  
- menuconfig ARCH_SHMOBILE_MULTI
+ menuconfig ARCH_RENESAS
 -      bool "Renesas ARM SoCs" if ARCH_MULTI_V7
 -      depends on MMU
 +      bool "Renesas ARM SoCs"
 +      depends on ARCH_MULTI_V7 && MMU
        select ARCH_SHMOBILE
+       select ARCH_SHMOBILE_MULTI
        select HAVE_ARM_SCU if SMP
        select HAVE_ARM_TWD if SMP
        select ARM_GIC
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/6704a56c/attachment.sig>
