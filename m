From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jul 2018 18:18:52 +0200
Subject: [GIT PULL] pinctrl: samsung: Stuff for v4.19
Message-ID: <20180725161852.6963-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.19

for you to fetch changes up to b3793159249bb091efce4b1515ce18cdfc4c6e41:

  dt-bindings: pinctrl: samsung: Add SPDX license identifier (2018-07-24 21:59:17 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v4.19

1. Add handling of external wakeup interrupts mask inside the pin
   controller driver.

   Existing solution is spread between the driver and machine code.  The
   machine code writes the mask but its value is taken from pin
   controller driver.

   This moves everything into pin controller driver allowing later to
   remove the cross-subsystem interaction.  Also this is a necessary
   step for implementing later Suspend to RAM on ARMv8 Exynos5433.

2. Bring necessary suspend/resume callbacks for Exynos542x and
   Exynos5260.
3. Document hidden requirement about one external wakeup interrupts
   device node.
4. Minor documentation cleanups.

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      pinctrl: samsung: Define suspend and resume callbacks for all banks and SoCs
      pinctrl: samsung: Document suspend and resume members
      pinctrl: samsung: Document hidden requirement about one external wakeup
      pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup interrupts
      ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and Exynos5433
      pinctrl: samsung: Write external wakeup interrupt mask
      dt-bindings: pinctrl: samsung: Add SPDX license identifier

 .../bindings/pinctrl/samsung-pinctrl.txt           | 11 +++-
 arch/arm/mach-exynos/suspend.c                     |  2 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       | 16 +++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 68 +++++++++++++++++++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h          | 11 ++++
 include/dt-bindings/pinctrl/samsung.h              |  7 +--
 include/linux/soc/samsung/exynos-regs-pmu.h        |  8 ++-
 7 files changed, 113 insertions(+), 10 deletions(-)
