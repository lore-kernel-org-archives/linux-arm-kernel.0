From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 23:28:07 +0800
Subject: [GIT PULL] ARM: mxs: fixes for 3.10
Message-ID: <20130603152803.GB13853@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-fixes-3.10

for you to fetch changes up to b5f83e9b069f4bf19214ca6130947806a2b853fa:

  ARM: mxs: icoll: Fix interrupts gpio bank 0 (2013-06-03 23:18:15 +0800)

----------------------------------------------------------------
The mxs fixes for 3.10:

- Since the time we move to MULTI_IRQ_HANDLER, the 0x7f polling for no
  interrupt in icoll_handle_irq() becomes insane, because 0x7f is an
  valid interrupt number, the irq of gpio bank 0.  That unnecessary
  polling results in the driver not detecting when irq 0x7f is active
  which makes the machine effectively dead lock.  The fix removes the
  interrupt poll loop and allows usage of gpio0 interrupt without an
  infinite loop.

----------------------------------------------------------------
Markus Pargmann (1):
      ARM: mxs: icoll: Fix interrupts gpio bank 0

 drivers/irqchip/irq-mxs.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)
