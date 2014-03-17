From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Mar 2014 16:35:06 +1100
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20140317163506.5770f06a77ba011e682f47ff@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in
arch/arm/mach-zynq/Kconfig between commit ddb902cc3459 ("ARM: centralize
common multi-platform kconfig options") from the arm-soc tree and commit
cd325295871f ("arm: zynq: Add support for cpufreq") from the tip tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-zynq/Kconfig
index 105d39b72a25,f03e75bd0b2b..000000000000
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@@ -2,10 -2,19 +2,12 @@@ config ARCH_ZYN
  	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
  	select ARM_AMBA
  	select ARM_GIC
+ 	select ARCH_HAS_CPUFREQ
+ 	select ARCH_HAS_OPP
 -	select COMMON_CLK
 -	select CPU_V7
 -	select GENERIC_CLOCKEVENTS
  	select HAVE_ARM_SCU if SMP
  	select HAVE_ARM_TWD if SMP
  	select ICST
 -	select MIGHT_HAVE_CACHE_L2X0
 -	select USE_OF
 -	select HAVE_SMP
 -	select SPARSE_IRQ
  	select CADENCE_TTC_TIMER
- 	select ARM_GLOBAL_TIMER
+ 	select ARM_GLOBAL_TIMER if !CPU_FREQ
  	help
  	  Support for Xilinx Zynq ARM Cortex A9 Platform
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/4bf67a6d/attachment.sig>
