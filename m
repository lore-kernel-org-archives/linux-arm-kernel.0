From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Nov 2009 11:19:47 -0800
Subject: [PATCH 00/10] Omap mailbox updates for omap4 for 2.6.33
Message-ID: <20091118191852.31148.93980.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are omap4 related mailbox changes for review.

Regards,

Tony

---

C A Subramaniam (6):
      omap: mailbox: Add build specific changes to support omap mailbox
      omap: mailbox: Add resources and mailbox register base address for OMAP4 mailbox
      omap: mailbox: remove unnecessary arg for omap_mbox_msg_send
      omap: mailbox: Adds code changes to support OMAP4 mailbox
      omap: mailbox: OMAP4 Mailbox Patch to change the IRQ flag from IRQF_DISABLED to IRQF_SHARED
      omap: mailbox: OMAP4 Mailbox-driver Patch to support tasklet implementation

Hiroshi DOYU (4):
      omap: mailbox: remove sequence bit checking
      omap: mailbox: remove class interface
      omap: mailbox: remove disable_/enable_mbox_irq in isr
      omap: mailbox: Expose omap_mbox_enable()/disable_irq()


 arch/arm/mach-omap2/Makefile               |    3 
 arch/arm/mach-omap2/devices.c              |   36 +++-
 arch/arm/mach-omap2/mailbox.c              |  140 ++++++++++++--
 arch/arm/plat-omap/include/plat/mailbox.h  |   23 ++
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 
 arch/arm/plat-omap/mailbox.c               |  282 +++++-----------------------
 6 files changed, 217 insertions(+), 269 deletions(-)

-- 
Signature
