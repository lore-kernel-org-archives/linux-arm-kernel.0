From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Jan 2014 22:35:36 +0100
Subject: [GIT PULL] Integrator changes for v3.14
Message-ID: <CACRpkdZ-rmWkNk_fkx_U78_fHQRRX=e64J0eXx1Y0UtetYD91A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

here are a few patches that have matured for the Integrators.
I have opted not to split these across branches as I don't think
there will be much more for this merge window.

irqchip patch is ACKed by TGLX, the clk stuff is ACKed by
Mike Turquette.

Please pull this into ARM SoC!

Yours,
Linus Walleij


The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:

  Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-for-v3.14

for you to fetch changes up to 8e048b9997efbe75fe77b1f14d3af41700cc8724:

  clk: versatile: fixup IM-PD1 clock implementation (2014-01-03 22:27:54 +0100)

----------------------------------------------------------------
Some Integrator patches that matured for v3.14:

- Use PATCH_PHYS_TO_VIRT and AUTO_ZRELADDR.

- Support cascaded interrupts on the SIC.

- Complete clock implementation for the IM-PD1.

----------------------------------------------------------------
Linus Walleij (4):
      irqchip: versatile FPGA: support cascaded interrupts from DT
      ARM: integrator: pass parent IRQ to the SIC
      clk: versatile: pass a name to ICST clock provider
      clk: versatile: fixup IM-PD1 clock implementation

panchaxari (1):
      ARM: integrator: Default enable ARM_PATCH_PHYS_VIRT, AUTO_ZRELADDR

 .../devicetree/bindings/arm/versatile-fpga-irq.txt |  5 ++
 arch/arm/Kconfig                                   |  2 +
 arch/arm/boot/dts/integratorcp.dts                 |  3 +
 drivers/clk/versatile/clk-icst.c                   |  3 +-
 drivers/clk/versatile/clk-icst.h                   |  1 +
 drivers/clk/versatile/clk-impd1.c                  | 88 ++++++++++++++++++----
 drivers/clk/versatile/clk-integrator.c             |  2 +-
 drivers/clk/versatile/clk-realview.c               |  6 +-
 drivers/irqchip/irq-versatile-fpga.c               | 15 +++-
 9 files changed, 103 insertions(+), 22 deletions(-)
