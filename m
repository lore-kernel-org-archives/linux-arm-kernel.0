From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 Jan 2013 14:14:11 +1100
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20130116141411.8fadedee54ed35dc0eddd288@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tegra tree got a conflict in
drivers/clocksource/Makefile between commit ff7ec345f0ec ("timer: vt8500:
Move timer code to drivers/clocksource") from the arm-soc tree and commit
ac0fd9eca3ba ("ARM: tegra: move timer.c to drivers/clocksource/") from
the tegra tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clocksource/Makefile
index 440449c,b5cc507..0000000
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@@ -17,6 -17,6 +17,7 @@@ obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= cl
  obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
  obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
 +obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
+ obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
  
  obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/ed67163e/attachment.sig>
