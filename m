From: eric@anholt.net (Eric Anholt)
Date: Thu, 24 Aug 2017 11:42:59 -0700
Subject: [GIT PULL] bcm2835-soc-next-2017-08-24
Message-ID: <20170824184259.24537-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Here's the new PR for the soc-next code, with the rewrite so that we
can drop the DT merge.  I think we can rewind soc-next to 4.13-rc1 and
merge this instead.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-soc-next-2017-08-24

for you to fetch changes up to b37f5361d22ab867fa6519a7f06b416cd46aee6c:

  ARM: bcm2836: Send event when onlining other cores (2017-08-24 11:31:55 -0700)

----------------------------------------------------------------
This pull request brings in a move of the bcm2836/7 SMP init code from
the irqchip driver to platsmp.c (general move acked by the maintainer,
v2 of the patch including a squashed in fix to prevent a dependency on
updated DT compatibles) and an added sev() to wake up the secondary
CPUs on newer firmware.  It also garbage collects some stub clock code
from before we had a proper clock driver, which has been acked by the
clk maintainers to go through the ARM trees.

----------------------------------------------------------------
Danilo Krummrich (1):
      clk: bcm2835: remove remains from stub clk driver

Phil Elwell (1):
      ARM: bcm2836: Send event when onlining other cores

Stefan Wahren (1):
      irqchip: bcm2836: Move SMP startup code to arch/arm (v2)

 arch/arm/mach-bcm/Makefile          |  5 +++
 arch/arm/mach-bcm/board_bcm2835.c   | 11 ++----
 arch/arm/mach-bcm/platsmp.c         | 38 ++++++++++++++++++
 arch/arm/mach-bcm/platsmp.h         | 10 +++++
 drivers/clk/bcm/clk-bcm2835-aux.c   |  1 -
 drivers/clk/bcm/clk-bcm2835.c       | 30 --------------
 drivers/irqchip/irq-bcm2836.c       | 79 +------------------------------------
 include/linux/clk/bcm2835.h         | 24 -----------
 include/linux/irqchip/irq-bcm2836.h | 70 ++++++++++++++++++++++++++++++++
 9 files changed, 129 insertions(+), 139 deletions(-)
 create mode 100644 arch/arm/mach-bcm/platsmp.h
 delete mode 100644 include/linux/clk/bcm2835.h
 create mode 100644 include/linux/irqchip/irq-bcm2836.h
