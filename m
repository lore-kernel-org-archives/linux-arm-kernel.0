From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Oct 2013 15:22:33 -0400 (EDT)
Subject: [GIT PULL] big.LITTLE switcher support, part 2
Message-ID: <alpine.LFD.2.03.1310041501380.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following:

  git://git.linaro.org/people/nico/linux iks_for_rmk

This is the second set of patches towards a fully functional and 
production quality switcher solution for big.LITTLE systems, 
establishing a landmark to compare against for any scheduler based 
solution meant to eventually surpass the switcher's power efficiency 
available in the mainline kernel.

This is based on your devel-stable as of now in order to get the first
set of patches.

The shortlog and diffstat follow:

Dave Martin (7):
      ARM: bL_switcher: Add synchronous enable/disable interface
      ARM: bL_switcher: Add runtime control notifier
      ARM: bL_switcher: Add switch completion callback for bL_switch_request()
      ARM: bL_switcher: Basic trace events support
      ARM: bL_switcher/trace: Add trace trigger for trace bootstrapping
      ARM: bL_switcher/trace: Add kernel trace trigger interface
      ARM: bL_switcher: Add query interface to discover CPU affinities

Nicolas Pitre (6):
      ARM: bL_switcher: synchronize the outbound with the inbound
      ARM: SMP: basic IPI triggered completion support
      ARM: mcpm: add a simple poke mechanism to the early entry code
      ARM: GIC: function to retrieve the physical address of the SGIR
      ARM: GIC: interface to send a SGI directly
      ARM: bL_switcher: wait until inbound is alive before performing a switch

 arch/arm/common/bL_switcher.c            | 264 ++++++++++++++++++++++---
 arch/arm/common/mcpm_entry.c             |  12 ++
 arch/arm/common/mcpm_head.S              |  16 +-
 arch/arm/include/asm/bL_switcher.h       |  62 +++++-
 arch/arm/include/asm/hardirq.h           |   2 +-
 arch/arm/include/asm/mcpm.h              |   8 +
 arch/arm/include/asm/smp.h               |   2 +
 arch/arm/kernel/smp.c                    |  21 ++
 drivers/irqchip/irq-gic.c                |  43 ++++
 include/linux/irqchip/arm-gic.h          |   2 +
 include/trace/events/power_cpu_migrate.h |  67 +++++++
 11 files changed, 471 insertions(+), 28 deletions(-)


Nicolas
