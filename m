From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 30 Jul 2014 12:23:05 +1000
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
Message-ID: <20140730122305.7b1b7838@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Today's linux-next merge of the pm tree got a conflict in
drivers/cpuidle/Kconfig.arm between commit 2aaafcdb6883 ("cpuidle:
big.LITTLE: Add ARCH_EXYNOS entry in config") from the arm-soc tree and
commit 6ee7f5dd57fc ("cpuidle: big_little: Fix build error") from the
pm tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/cpuidle/Kconfig.arm
index 33fc0ff0af1c,a186dec8e5df..000000000000
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@@ -1,9 -1,16 +1,10 @@@
  #
  # ARM CPU Idle drivers
  #
 -config ARM_ARMADA_370_XP_CPUIDLE
 -	bool "CPU Idle Driver for Armada 370/XP family processors"
 -	depends on ARCH_MVEBU
 -	help
 -	  Select this to enable cpuidle on Armada 370/XP processors.
 -
  config ARM_BIG_LITTLE_CPUIDLE
  	bool "Support for ARM big.LITTLE processors"
 -	depends on ARCH_VEXPRESS_TC2_PM
 +	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
+ 	depends on MCPM
  	select ARM_CPU_SUSPEND
  	select CPU_IDLE_MULTIPLE_DRIVERS
  	help
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/683fcf92/attachment.sig>
