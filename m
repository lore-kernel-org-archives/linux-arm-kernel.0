From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 14:31:11 +0100
Subject: [GIT PULL] RealView base patches for cleanup and DT
Message-ID: <CACRpkdZAD-eh8k5RchnAjWyfRBiD0AN0qg_YHhwM6o001rTSQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

this is the base stack of patches piled up for the RealView platforms.
It basically adds a set of cleanups from Arnd and device tree support
for the RealView PB11MPCore. The stack has been tested on hardware.

Both Arnd and I have outstanding patches towards the goals of
modernizing the RealView machines, but these patches are known to
be stable and working so let's merge this part now so it gets some
rotation in linux-next.

I think the clk patches are missing an ACK from Mike Turquette but I don't
think he would mind. There has been some revisions of them after feedback
and it looks good to me.

This series requires an orthogonal series for the interrupt controller
on the PB11MPCore, which will be merged on its own in the irqchips
tree by Marc Zyngier.

Please pull this in!

Yours,
Linus Walleij


The following changes since commit 527e9316f8ec44bd53d90fb9f611fa7ffff52bb9:

  Linux 4.4-rc4 (2015-12-06 15:43:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-base-armsoc

for you to fetch changes up to 1c12923c05c95e5626cef705411fa9a873e71cef:

  ARM: realview: add device tree for PB11MPCore (2015-12-10 14:26:51 +0100)

----------------------------------------------------------------
Base patches for RealView clean-up and DT support.

----------------------------------------------------------------
Arnd Bergmann (5):
      ARM: realview: remove sparsemem hack
      ARM: realview: don't map undefined PCI registers
      clk/realview: stop using machine headers
      ARM: no longer force unbuffered DMA for realview
      ARM: realview: remove private barrier implementation

Linus Walleij (9):
      ARM: add DT bindings for the ARM11MPCore CPU cluster
      clk: versatile-icst: convert to use regmap
      clk: versatile-icst: refactor to allocate regmap separately
      clk: add ARM syscon ICST device tree bindings
      clk: versatile-icst: add device tree support
      soc: versatile: add support for the PB11MPCore
      ARM: realview: select SP810 and ICST for the DT variant
      ARM: realview: add an DT SMP boot method
      ARM: realview: add device tree for PB11MPCore

 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 Documentation/devicetree/bindings/arm/scu.txt      |   3 +
 .../devicetree/bindings/clock/arm-syscon-icst.txt  |  40 ++
 arch/arm/Kconfig                                   |   2 -
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          | 668 +++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                     |  11 +-
 arch/arm/mach-realview/Makefile                    |   2 +-
 arch/arm/mach-realview/include/mach/barriers.h     |   8 -
 arch/arm/mach-realview/include/mach/memory.h       |  64 --
 arch/arm/mach-realview/platsmp-dt.c                |  91 +++
 arch/arm/mach-realview/realview_eb.c               |   7 +
 arch/arm/mach-realview/realview_pb11mp.c           |   6 +
 arch/arm/mach-realview/realview_pba8.c             |   8 -
 arch/arm/mach-realview/realview_pbx.c              |   8 -
 arch/arm/mm/Kconfig                                |   2 -
 drivers/clk/versatile/Kconfig                      |   1 +
 drivers/clk/versatile/clk-icst.c                   | 194 +++++-
 drivers/clk/versatile/clk-realview.c               |  10 +-
 drivers/soc/versatile/soc-realview.c               |   4 +
 20 files changed, 998 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/arm-syscon-icst.txt
 create mode 100644 arch/arm/boot/dts/arm-realview-pb11mp.dts
 delete mode 100644 arch/arm/mach-realview/include/mach/barriers.h
 delete mode 100644 arch/arm/mach-realview/include/mach/memory.h
 create mode 100644 arch/arm/mach-realview/platsmp-dt.c
