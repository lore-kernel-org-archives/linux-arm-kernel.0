From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Aug 2013 18:04:25 +1000
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
Message-ID: <20130829180425.4aa3d164f01cc65b215187fe@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/cpuidle/Makefile between commits b98e01ad4ed9 ("cpuidle: Add
Kconfig.arm and move calxeda, kirkwood and zynq") and d3f2950f2ade ("ARM:
ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle") from the
pm tree and commit 14d2c34cfa00 ("cpuidle: big.LITTLE: vexpress-TC2 CPU
idle driver") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/cpuidle/Makefile
index 0b9d200,3b6445c..0000000
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@@ -5,9 -5,7 +5,10 @@@
  obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
  
 -obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
 -obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
 -obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
 -obj-$(CONFIG_CPU_IDLE_BIG_LITTLE) += cpuidle-big_little.o
 +##################################################################################
 +# ARM SoC drivers
 +obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 +obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 +obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 +obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
++obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)       += cpuidle-big_little.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/08786bd3/attachment.sig>
