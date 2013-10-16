From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Oct 2013 14:27:13 +0200
Subject: [GIT PULL] Integrator patches for v3.13
Message-ID: <CACRpkdbdpJByijRjOZKpEB_5tZt9xro1DLmVXsgrixe9YJTbZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is a second try at an Integrator patch stack for v3.13.
This addresses the issues reported by Mark Rutland and
adds two patches on top for some more things he wanted
me to fix as well.

Further this folds in a defconfig patch and the LED fix.
The LED fix is DT-related, and the defconfig change is
related to the LED fix, so they all belong in the same series.

The cpufreq patch is ACKed by both cpufreq maintainers.

Please pull this to some suitable branch in the
ARM SoC tree.

Yours,
Linus Walleij

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-for-v3.13-2

for you to fetch changes up to df36680f1a71eef97685c30eb9eaf55a6813b6cd:

  ARM: integrator: core module registers from compatible strings
(2013-10-16 14:10:14 +0200)

----------------------------------------------------------------
Integrator patches for the v3.13 kernel cycle:
- Fix up the LED support
- Update the Integrator defconfig
- Remove ATAG boot path
- Move some stuff over to the device tree

----------------------------------------------------------------
Linus Walleij (10):
      ARM: integrator: get the CM control register by proxy
      ARM: integrator: update defconfig
      ARM: integrator: get the LM interrupts from DT
      ARM: integrator: print the Linux IRQ in LL_DEBUG code
      ARM: integrator: delete non-devicetree boot path
      ARM: integrator: decommission the <mach/irqs.h> header
      ARM: integrator: move CM base into device tree
      cpufreq: probe the Integrator cpufreq driver from DT
      ARM: integrator: use devm_ioremap() to remap CM
      ARM: integrator: core module registers from compatible strings

 Documentation/devicetree/bindings/arm/arm-boards |  50 +++++-
 arch/arm/Kconfig                                 |   1 +
 arch/arm/boot/dts/integrator.dtsi                |   5 +
 arch/arm/boot/dts/integratorap.dts               |   5 +-
 arch/arm/boot/dts/integratorcp.dts               |   4 +-
 arch/arm/configs/integrator_defconfig            |  25 ++-
 arch/arm/mach-integrator/{include/mach => }/cm.h |   7 +-
 arch/arm/mach-integrator/core.c                  | 182 ++++++++++------------
 arch/arm/mach-integrator/include/mach/irqs.h     |  81 ----------
 arch/arm/mach-integrator/integrator_ap.c         | 152 ++-----------------
 arch/arm/mach-integrator/integrator_cp.c         | 185 ++---------------------
 arch/arm/mach-integrator/leds.c                  |   5 +-
 arch/arm/mach-integrator/pci_v3.c                | 127 ++++------------
 drivers/cpufreq/integrator-cpufreq.c             |  61 +++++---
 14 files changed, 251 insertions(+), 639 deletions(-)
 rename arch/arm/mach-integrator/{include/mach => }/cm.h (88%)
 delete mode 100644 arch/arm/mach-integrator/include/mach/irqs.h
