From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 07 Dec 2011 19:29:48 +0530
Subject: [PATCH 0/4] arm: exynos4: add irq domain and device tree support for
 wakeup interrupts
Message-ID: <1323266392-28330-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung Exynos4 includes 32 external wakeup interrupt sources. This patchset
adds irq domain and device tree support for these interrupts.

This patchset is based on the following tree.
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git  for-next

This patchset depends on the following patch from Jamie Iles.
irqdomain: export irq_domain._simple_op.s for !CONFIG_OF

Thomas Abraham (4):
  arm: exynos4: simplify EINT number to GIC irq number translation
  arm: exynos4: add irq_domain support for wakeup interrupts
  arm: exynos4: remove arch_initcall for wakeup interrupt source initialization
  arm: exynos4: add device tree support for external wakeup interrupt controller

 .../bindings/arm/samsung/wakeup-eint.txt           |   14 +++
 arch/arm/mach-exynos/cpu.c                         |    4 +
 arch/arm/mach-exynos/include/mach/regs-gpio.h      |    4 +-
 arch/arm/mach-exynos/irq-eint.c                    |  101 +++++++++++---------
 arch/arm/plat-samsung/include/plat/exynos4.h       |    1 +
 5 files changed, 75 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
