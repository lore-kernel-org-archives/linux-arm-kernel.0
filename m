From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:43 -0400
Subject: [PATCH 00/13] second batch of b.L switcher patches
Message-ID: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first batch of patches was posted here:

  http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=253942

They're now merged in RMK's devel-stable branch and also available via
the linux-next tree.

So here's the second set of patches towards a fully functional and
production quality switcher solution, establishing a landmark to compare
against for any scheduler based solution meant to eventually surpass the
switcher in the mainline kernel.

Those patches are also available here:

  git://git.linaro.org/people/nico/linux iks

This set is divided in 3 groups:

Patches 1 to 3 are needed for proper interaction and synchronization with
the cpufreq companion driver that will be posted separately.

Patches 4 to 9 are providing significant switch latency and efficiency
improvements and are purely for optimization purposes.

Patches 10 to 13 are for switch event tracing.

Here's the diffstat:

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
