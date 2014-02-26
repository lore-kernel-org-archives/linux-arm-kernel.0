From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Feb 2014 14:04:39 +0100
Subject: [GIT PULL] Integrator multiplatform patches, take two
Message-ID: <CACRpkdbWNNcQCa0XLHo_CPOcjBNAPORhaZ9+ct1QWaLJjFoxMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is anoter package of multiplatform patches for v3.15, clearing the
view with the final objective in clear sight.

I have tested to pull this cleanly on top of your
integrator/multiplatform-base branch, so it can be pulled on top
of that.

Two things remain to be solved after this:

- Handle the CLCD display database and/or convert this to use the
  device tree somehow.

- Handle the <mach/memory.h> bus offset stuff assumed to be there for
  PCI DMA in an elegant way.

So these have to be hashed out next.

After that we can go full multiplatform for the Integrator, clearing the way
for Versatile and RealView as well.

Please pull this in!

Yours,
Linus Walleij


The following changes since commit 29525484cd2524a31ee0924831ab43b46ea6ebe1:

  ARM: integrator: select GPIO block (2014-02-13 11:21:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-for-v3.15-2

for you to fetch changes up to a79528e9d849803457b6235ddb1a1cfd4e11c6cd:

  ARM: integrator: register sched_clock directly (2014-02-26 13:49:07 +0100)

----------------------------------------------------------------
Integrator multiplatform patches for v3.15, set two:

- Remove all dangling header files in <mach/*> from the global
  namespace and push them down into the mach-integrator folder.

- Decouple the Integrator from the plat-versatile sched_clock
  implementation.

----------------------------------------------------------------
Linus Walleij (5):
      ARM: integrator: localize the lm.h header
      ARM: integrator: localize the impd1.h header
      ARM: integrator: merge platform.h to hardware.h
      ARM: integrator: localize the hardware.h header
      ARM: integrator: register sched_clock directly

 arch/arm/mach-integrator/core.c                    |   4 +-
 .../{include/mach/platform.h => hardware.h}        | 110 ++++++++-------------
 arch/arm/mach-integrator/impd1.c                   |   4 +-
 .../arm/mach-integrator/{include/mach => }/impd1.h |   4 -
 arch/arm/mach-integrator/include/mach/hardware.h   |  45 ---------
 arch/arm/mach-integrator/integrator_ap.c           |   6 +-
 arch/arm/mach-integrator/integrator_cp.c           |  17 ++--
 arch/arm/mach-integrator/leds.c                    |   4 +-
 arch/arm/mach-integrator/lm.c                      |   2 +-
 arch/arm/mach-integrator/{include/mach => }/lm.h   |   0
 arch/arm/mach-integrator/pci_v3.c                  |   4 +-
 drivers/clk/versatile/clk-impd1.c                  |   6 +-
 12 files changed, 61 insertions(+), 145 deletions(-)
 rename arch/arm/mach-integrator/{include/mach/platform.h => hardware.h} (81%)
 rename arch/arm/mach-integrator/{include/mach => }/impd1.h (83%)
 delete mode 100644 arch/arm/mach-integrator/include/mach/hardware.h
 rename arch/arm/mach-integrator/{include/mach => }/lm.h (100%)
