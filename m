From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Apr 2011 15:50:35 +0100
Subject: [PATCH 0/6] Use chained handler entry/exit functions in platform code
Message-ID: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Commit 10a8c383 ("ARM: irq: introduce entry and exit functions for
chained handlers") added chained handler entry/exit functions in
preparation for moving the GIC to fasteoi flow control.

This series of patches updates the relevant platforms to use the new
functions so that when the GIC changes its flow control type, breakage
will not occur.

I've included the GIC patch as the final patch (6) in the series so you
can test the change easily enough on your favourite platform.

All Acked-bys/Tested-bys greatly appreciated!

Cheers,

Will


Will Deacon (6):
  ARM: omap: update GPIO chained IRQ handler to use entry/exit
    functions
  ARM: tegra: update GPIO chained IRQ handler to use entry/exit
    functions
  ARM: s5pv310: update IRQ combiner to use chained entry/exit functions
  ARM: msm: update GPIO chained IRQ handler to use entry/exit functions
  ARM: nmk: update GPIO chained IRQ handler to entry/exit functions
  ARM: gic: use handle_fasteoi_irq for SPIs

 arch/arm/common/gic.c                |   24 +++++++++---------------
 arch/arm/mach-exynos4/irq-combiner.c |    6 ++----
 arch/arm/mach-msm/gpio-v2.c          |    6 +++++-
 arch/arm/mach-tegra/gpio.c           |    7 ++++---
 arch/arm/plat-nomadik/gpio.c         |   10 ++--------
 arch/arm/plat-omap/gpio.c            |    7 ++++---
 6 files changed, 26 insertions(+), 34 deletions(-)
