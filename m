From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Feb 2014 11:22:10 -0500
Subject: [GIT PULL] irqchip: mvebu fixes for v3.14
Message-ID: <20140218162210.GU7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Here is a small round of fixes for irq-orion.c.  They've been in -next
for over a week.  Please pull.

We have a set of watchdog changes depending on this that are going
through mvebu/arm-soc.  So please don't rebase, just let me know if
there's something that isn't right.  I'll fix it up and resend.

thx,

Jason.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/irqchip-mvebu-fixes-3.14

for you to fetch changes up to 12bd4f7c135482fd097e7e169308d84b72c32b69:

  IRQ: Orion: Fix getting generic chip pointer. (2014-02-08 15:42:07 +0000)

----------------------------------------------------------------
irqchip mvebu fixes for v3.14

 - orion:
    - fixes for clearing bridge cause register, and clearing stale interrupts

----------------------------------------------------------------
Andrew Lunn (1):
      IRQ: Orion: Fix getting generic chip pointer.

Sebastian Hesselbarth (3):
      irqchip: orion: clear bridge cause register on init
      irqchip: orion: use handle_edge_irq on bridge irqs
      irqchip: orion: clear stale interrupts in irq_startup

 drivers/irqchip/irq-orion.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)
