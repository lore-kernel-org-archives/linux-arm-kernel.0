From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:25:45 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm64 tree
Message-ID: <20120924192545.09a1327b66005e0ac967faaf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/clocksource/Makefile between commit 985c0679dfa4 ("arm64: Generic
timers support") from the arm64 tree and commit ee4af5696720 ("ARM:
bcm2835: add system timer") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clocksource/Makefile
index 6591990,d496a55..0000000
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@@ -13,4 -13,4 +13,5 @@@ obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_ti
  obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
  obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
  obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 +obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
+ obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/b95d782d/attachment.sig>
