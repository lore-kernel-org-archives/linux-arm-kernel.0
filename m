From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Oct 2013 09:11:32 +0200
Subject: [GIT PULL] Integrator device tree migration for v3.13
Message-ID: <CACRpkdY--WanMfoW_9hFV41LibvhBS+iK+tHSASqvNVWFrbb6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a first set of Integrator device tree migration patches,
I'm still working to extend this series and move toward single
zImage for the Integrator, but this would be good to get in as
a base.

Along with the fix for the timer that I sent yesterday this makes
both Integrator/AP and Integrator/CP booth flawlessly from
Device Tree.

Necessary patches to U-Boot are also upstream and
precompiled binaries can be found on my Integrator webpage:
http://www.df.lth.se/~triad/krad/integrator/

Please pull them in!

Yours,
Linus Walleij


The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-for-v3.13-1

for you to fetch changes up to 604dc822ccc4fb10214e9ea09545c59ba74dddfe:

  cpufreq: probe the Integrator cpufreq driver from DT (2013-10-08
09:02:06 +0200)

----------------------------------------------------------------
This starts to migrate the ARM Integrator boards to a pure
Device Tree boot path.

- Move the final references to old interrupt layout to use
  Linux IRQs
- Delete the ATAG boot path and select USE_OF
- Delete the IRQ header
- Start to move over the final pieces to DT

----------------------------------------------------------------
Linus Walleij (6):
      ARM: integrator: get the LM interrupts from DT
      ARM: integrator: print the Linux IRQ in LL_DEBUG code
      ARM: integrator: delete non-devicetree boot path
      ARM: integrator: decommission the <mach/irqs.h> header
      ARM: integrator: move CM base into device tree
      cpufreq: probe the Integrator cpufreq driver from DT

 Documentation/devicetree/bindings/arm/arm-boards |  35 ++++-
 arch/arm/Kconfig                                 |   1 +
 arch/arm/boot/dts/integrator.dtsi                |   5 +
 arch/arm/boot/dts/integratorap.dts               |   3 +
 arch/arm/mach-integrator/{include/mach => }/cm.h |   4 +-
 arch/arm/mach-integrator/core.c                  | 178 ++++++++++-------------
 arch/arm/mach-integrator/include/mach/irqs.h     |  81 -----------
 arch/arm/mach-integrator/integrator_ap.c         | 144 +-----------------
 arch/arm/mach-integrator/integrator_cp.c         | 177 +---------------------
 arch/arm/mach-integrator/leds.c                  |   3 +-
 arch/arm/mach-integrator/pci_v3.c                | 127 ++++------------
 drivers/cpufreq/integrator-cpufreq.c             |  56 ++++---
 12 files changed, 193 insertions(+), 621 deletions(-)
 rename arch/arm/mach-integrator/{include/mach => }/cm.h (93%)
 delete mode 100644 arch/arm/mach-integrator/include/mach/irqs.h
