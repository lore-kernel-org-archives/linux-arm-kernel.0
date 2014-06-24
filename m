From: robherring2@gmail.com (Rob Herring)
Date: Tue, 24 Jun 2014 14:35:18 -0500
Subject: [GIT PULL] ARM: versatile: DT IRQ and clock support
Message-ID: <CAL_JsqKkfDd3h+iW7UUJiUgULSma=bs=muTTyCo3HOWHi30LVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull for 3.17.

I've tested this on qemu, but still need Linus to test on h/w. He did
test an earlier version.

Rob

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/versatile-for-3.17

for you to fetch changes up to a54c959d8be9d057b1a192e34a378b74dd81c5f6:

  clk: versatile: add versatile OSC support (2014-06-24 14:21:22 -0500)

----------------------------------------------------------------
DT IRQ and clock support for Versatile platforms

----------------------------------------------------------------
Rob Herring (11):
      dts: versatile: add missing irq controller properties
      irqchip: versatile-fpga: Add IRQCHIP_DECLARE support
      irqchip: versatile-fpga: add support for arm,versatile-sic
      ARM: integrator: convert to use irqchip_init
      ARM: versatile: remove init_irq hook for DT boot
      dts: versatile: add pl180 compatible strings
      dt/bindings: arm-boards: add binding for Versatile core module
      dt/bindings: add compatible string for versatile osc clock
      ARM: timer-sp: allow getting timer1 clock from DT to fallback to
legacy clock
      dts: versatile: add clock tree
      clk: versatile: add versatile OSC support

 Documentation/devicetree/bindings/arm/arm-boards   |  6 ++
 .../devicetree/bindings/clock/arm-integrator.txt   |  4 +-
 arch/arm/boot/dts/versatile-ab.dts                 | 81 +++++++++++++++++++++-
 arch/arm/boot/dts/versatile-pb.dts                 | 12 +++-
 arch/arm/common/timer-sp.c                         |  4 +-
 arch/arm/mach-integrator/integrator_ap.c           | 10 +--
 arch/arm/mach-integrator/integrator_cp.c           | 10 +--
 arch/arm/mach-versatile/versatile_dt.c             |  1 -
 drivers/clk/versatile/Makefile                     |  3 +-
 .../{clk-integrator.c => clk-versatile.c}          | 38 +++++++++-
 drivers/irqchip/irq-versatile-fpga.c               | 18 ++++-
 11 files changed, 158 insertions(+), 29 deletions(-)
 rename drivers/clk/versatile/{clk-integrator.c => clk-versatile.c} (63%)
