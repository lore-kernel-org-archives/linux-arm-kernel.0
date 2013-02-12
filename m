From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 12 Feb 2013 14:56:01 +1100
Subject: linux-next: manual merge of the arm-soc tree with the metag tree
Message-ID: <20130212145601.09b536bef18ae4f3c8d3b3cc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
drivers/clocksource/Makefile and drivers/clocksource/Kconfig between
commit 3fedb0674fbc ("metag: Time keeping") from the metag tree and
commits 8a4da6e36c58 ("arm: arch_timer: move core to
drivers/clocksource") and  ("arm64: move from arm_generic to
arm_arch_timer") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clocksource/Kconfig
index 75bc752,e920cbe..0000000
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@@ -54,12 -60,5 +60,10 @@@ config CLKSRC_DBX500_PRCMU_SCHED_CLOC
  	help
  	  Use the always on PRCMU Timer as sched_clock
  
- config CLKSRC_ARM_GENERIC
- 	def_bool y if ARM64
- 	help
- 	  This option enables support for the ARM generic timer.
+ config ARM_ARCH_TIMER
+ 	bool
 +
 +config CLKSRC_METAG_GENERIC
 +	def_bool y if METAG
 +	help
 +	  This option enables support for the Meta per-thread timers.
diff --cc drivers/clocksource/Makefile
index 09dcd49,7d671b8..0000000
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@@ -16,6 -17,7 +17,8 @@@ obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= cl
  obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
  obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
+ obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
+ obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
  
- obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
+ obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 +obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/b983361c/attachment.sig>
