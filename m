From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Apr 2013 17:57:52 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20130402175752.b6ff90247b873b67111d31ad@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
drivers/clocksource/Makefile between commit 275786b71d42 ("ARM: sirf: use
clocksource_of infrastructure") from the arm-soc tree and commit
c74512bf83f3 ("ARM: mxs: move timer driver into drivers/clocksource")
from the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clocksource/Makefile
index 5e2176f,89c5adc..0000000
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@@ -16,8 -16,7 +16,9 @@@ obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nom
  obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
  obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 +obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
 +obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
+ obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
  obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
  obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
  obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/011cc601/attachment.sig>
