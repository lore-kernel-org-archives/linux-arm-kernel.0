From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Aug 2017 16:15:08 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.13
Message-ID: <CAK8P3a0XZOZSgNB6yJX0fXoGMwJaMBS9GP-JYzX+XpkuXbuG7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4dd6a9973b8aaffac4bf37c5bb70e8eae5a7afb4:

  soc: ti: ti_sci_pm_domains: Populate name for genpd (2017-08-18
11:59:53 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to 93a4c8355e0e448d83f31801b4c72f66e4360975:

  ARM: dts: exynos: add needs-hpd for Odroid-XU3/4 (2017-08-23 21:43:29 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.13

A small number of bugfixes, again nothing serious.

- Alexander Dahl found multiple bugs in the Atmel memory interface driver

- A randconfig build fix for at91 was incomplete, the second
  attempt fixes the remaining corner case

- One fix for the TI Keystone queue handler

- The Odroid XU4 HDMI port (added in 4.13) needs a small DT fix

----------------------------------------------------------------
Alexander Dahl (3):
      memory: atmel-ebi: Fix smc timing return value evaluation
      memory: atmel-ebi: Allow t_DF timings of zero ns
      memory: atmel-ebi: Fix smc cycle xlate converter

Arnd Bergmann (2):
      Merge tag 'at91-ab-4.13-drivers-fixes' of
git://git.kernel.org/.../abelloni/linux into fixes
      ARM: at91: don't select CONFIG_ARM_CPU_SUSPEND for old platforms

Hans Verkuil (1):
      ARM: dts: exynos: add needs-hpd for Odroid-XU3/4

Keerthy (1):
      soc: ti: knav: Add a NULL pointer check for kdev in knav_pool_create

 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 arch/arm/mach-at91/Kconfig                         |  2 +-
 arch/arm/mach-at91/pm.c                            | 12 ++++++++++++
 drivers/memory/atmel-ebi.c                         | 10 ++++++----
 drivers/mfd/atmel-smc.c                            |  2 +-
 drivers/soc/ti/knav_qmss_queue.c                   |  3 +++
 6 files changed, 24 insertions(+), 6 deletions(-)
