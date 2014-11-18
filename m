From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Nov 2014 08:43:28 +0100
Subject: [GIT PULL] ARM SoC Integrator updates for v3.19
Message-ID: <CACRpkdaNEoVVzcPs9apjBTP0P2z1hQ4btFfiBGt=-JzsuTOqfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this pull request for the Integrator is supposed to land on
top of the multiplatform pull request merged earlier, wherever
that was merged.

It needs to be merged on top of those patches since
multiplatform moves around in arch/arm/mach-integrator/Kconfig
and these features hit that file a lot.

By just looking at the diffstat you can see that this patchset
does GoodStuff(TM).

Please pull this in for v3.19!

Yours,
Linus Walleij


The following changes since commit 9713497b6c64c67c8763f8f07fad325b193764b6:

  ARM: integrator: set V4T and V5 as default multitargets (2014-10-22
09:49:26 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-v3.19-arm-soc-2

for you to fetch changes up to f956a785a282f6b5a3e7d59937548f8b7c04d1ac:

  soc: move SoC driver for the ARM Integrator (2014-11-13 10:32:05 +0100)

----------------------------------------------------------------
Integrator updates for the v3.19 merge cycle on
top of the multiplatform patches, this moves out
some drivers and reduced the amount of code carried
in arch/arm/mach-integrator.

- Move the Integrator/AP timer to drivers/clocksource
- Move the restart functionality to the device tree,
  patches to enable restart for the Integrator have
  been merged to the reset tree (orthogonal)
- Move debug LEDs to device tree (using the syscon
  LED driver merged for v3.18)
- Move core module LEDs to device tree (using the
  syscon LED driver merged for v3.18)
- Move the SoC driver (chip ID etc) to
  drivers/soc/versatile/soc-integrator.c

----------------------------------------------------------------
Linus Walleij (5):
      ARM: integrator: move AP timer to clocksource
      ARM: integrator: move restart to the device tree
      ARM: integrator: move debug LEDs to syscon LED driver
      ARM: integrator: move core module LED to device tree
      soc: move SoC driver for the ARM Integrator

 arch/arm/boot/dts/integrator.dtsi         |  48 ++++++-
 arch/arm/mach-integrator/Kconfig          |   5 +
 arch/arm/mach-integrator/Makefile         |   2 +-
 arch/arm/mach-integrator/cm.h             |   1 -
 arch/arm/mach-integrator/common.h         |   2 -
 arch/arm/mach-integrator/core.c           | 103 --------------
 arch/arm/mach-integrator/integrator_ap.c  | 218 ------------------------------
 arch/arm/mach-integrator/integrator_cp.c  |  28 ----
 arch/arm/mach-integrator/leds.c           | 124 -----------------
 drivers/clocksource/Makefile              |   1 +
 drivers/clocksource/timer-integrator-ap.c | 210 ++++++++++++++++++++++++++++
 drivers/soc/versatile/Kconfig             |   9 ++
 drivers/soc/versatile/Makefile            |   1 +
 drivers/soc/versatile/soc-integrator.c    | 154 +++++++++++++++++++++
 14 files changed, 428 insertions(+), 478 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/leds.c
 create mode 100644 drivers/clocksource/timer-integrator-ap.c
 create mode 100644 drivers/soc/versatile/soc-integrator.c
