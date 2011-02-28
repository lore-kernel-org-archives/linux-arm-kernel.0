From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Feb 2011 13:33:36 +0000
Subject: [PATCH v2 0/6] Migrate GIC to fasteoi flow control
Message-ID: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the patch series originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/043083.html

Changes since v1:

	* Added plat-nomadik changes after related patch from Rabin
	* Fixed msm changes to call irq_eoi correctly
	* No longer in quoted-printable encoding (thanks Colin)

This is going to be a PITA to merge so any thoughts relating to that
are welcome.

Thanks,

Will


Will Deacon (6):
  ARM: gic: use handle_fasteoi_irq for SPIs
  ARM: omap: update GPIO chained IRQ handler to use EOI in parent chip
  ARM: tegra: update GPIO chained IRQ handler to use EOI in parent chip
  ARM: s5pv310: update IRQ combiner to use EOI in parent chip
  ARM: msm: update GPIO chained IRQ handler to use EOI in parent chip
  ARM: nmk: update GPIO chained IRQ handler to use EOI in parent chip

 arch/arm/common/gic.c                |   23 +++++++++--------------
 arch/arm/mach-msm/gpio-v2.c          |    3 ++-
 arch/arm/mach-s5pv310/irq-combiner.c |    7 ++-----
 arch/arm/mach-tegra/gpio.c           |   17 +----------------
 arch/arm/plat-nomadik/gpio.c         |    2 ++
 arch/arm/plat-omap/gpio.c            |    5 ++++-
 6 files changed, 20 insertions(+), 37 deletions(-)
