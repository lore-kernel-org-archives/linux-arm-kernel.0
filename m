From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Apr 2011 19:35:34 +0100
Subject: [PATCH v2 0/6] Use chained handler entry/exit functions in platform
	code
Message-ID: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the patches originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/046905.html

Changes since v1:

	* Updated to irq_desc_get_chip
	* Fixed missing includes
	* Updated Tegra IRQ handling
	* Based on -rc3

Colin - Please can you look at the changes I've made to mach-tegra/irq.c?
I'd also value some feedback on how you'd like to see this merged. See
my previous post here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/047253.html

Please test/ack/complain wherever possible,

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

 arch/arm/common/gic.c                |   32 ++++++++++++++++----------------
 arch/arm/mach-exynos4/irq-combiner.c |    6 ++----
 arch/arm/mach-msm/gpio-v2.c          |   10 ++++++++--
 arch/arm/mach-tegra/gpio.c           |    9 ++++++---
 arch/arm/mach-tegra/irq.c            |   12 ++++++------
 arch/arm/plat-nomadik/gpio.c         |   12 ++++--------
 arch/arm/plat-omap/gpio.c            |    7 ++++---
 7 files changed, 46 insertions(+), 42 deletions(-)
