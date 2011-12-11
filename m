From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 11 Dec 2011 12:21:37 +0530
Subject: [PATCH v2 0/4] ARM: Exynos4: Add irq domain and device tree support
 for wakeup interrupts
Message-ID: <1323586301-24537-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1: (only patch 4/4 has changes)
- Fixes based on Rob's comments:
  a. Fixed the function prototype of exynos4_init_irq_eint(void)
  b. Included interrupt-parent as an optional property for wakeup interrupt
      controller node.

Samsung Exynos4 includes 32 external wakeup interrupt sources. This patchset
adds irq domain and device tree support for these interrupts.

This patchset is based on the following tree.
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git  for-next

This patchset should be applied after applying the following patch.
[PATCH] ARM: Exynos: Add irq domain and device tree support for interrupt combiner

This patchset depends on the following patch from Jamie Iles.
[PATCH] irqdomain: export irq_domain._simple_op.s for !CONFIG_OF

Thomas Abraham (4):
  arm: exynos4: simplify EINT number to linux irq number translation
  arm: exynos4: add irq_domain support for wakeup interrupts
  arm: exynos4: remove arch_initcall for wakeup interrupt source initialization
  arm: exynos4: add device tree support for external wakeup interrupt controller

 .../bindings/arm/samsung/wakeup-eint.txt           |   26 +++++
 arch/arm/mach-exynos/cpu.c                         |    6 +-
 arch/arm/mach-exynos/include/mach/regs-gpio.h      |    4 +-
 arch/arm/mach-exynos/irq-eint.c                    |   98 ++++++++++----------
 arch/arm/plat-samsung/include/plat/exynos4.h       |    4 +
 5 files changed, 86 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
