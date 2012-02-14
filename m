From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 14 Feb 2012 18:56:08 +0100
Subject: [PATCH v3 0/4] ARM: OMAP2+: Interrupt controllers adaptation to DT
Message-ID: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony and Rob,

Here is a small update of the INTC controller series that was already
acked-by in the v2 [1].
This version is just updating the #2 patch to take advantage of the new
irq_domain_add_legacy API introduced by Grant.

Please note that in the near future that code can even be simplier with
the introduction of the domain support inside generic irq chip.

This series is based on lo/master + for_3.4/dt_base branch to get the needed
cleanup and fixes for OMAP.
It requires as well Grant's irq_domain generalization and refinement
series available at:
  git://git.secretlab.ca/git/linux-2.6 irqdomain/next

The series is available here for reference:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_irq_domain

Regards,
Benoit


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/079467.html


Benoit Cousson (4):
  arm/dts: OMAP4: Update DTS file with new GIC bindings
  ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
  arm/dts: OMAP3: Add interrupt-controller bindings for INTC
  ARM: OMAP2+: board-generic: Use of_irq_init API

 .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 +-
 arch/arm/boot/dts/omap4.dtsi                       |    2 +-
 arch/arm/mach-omap2/board-generic.c                |   30 +++++-----
 arch/arm/mach-omap2/common.h                       |   10 +++
 arch/arm/mach-omap2/irq.c                          |   59 ++++++++++++++++---
 6 files changed, 107 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
