From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 10 Jun 2014 09:27:36 +0800
Subject: [PATCH 00/12] clk: mmp: clock device tree support
Message-ID: <1402363668-25806-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The patch set focuses at support device tree for clock.

The first part of the patches
  clk: mmp: add prefix "mmp" for structures defined for clk-frac
  clk: mmp: add spin lock for clk-frac
  clk: mmp: add init callback for clk-frac
  clk: mmp: move definiton of mmp_clk_frac to clk.h
It enhances the clk-frac.

The second part of the patches
  clk: mmp: add clock type mix
  clk: mmp: add mmp private gate clock
  clk: mmp: add clock type composite for mix
It add three new types of clocks.

The third part of the patches
  clk: mmp: add clock type master
  clk: mmp: add spin lock automatic detection from device tree
  clk: mmp: add device tree support for composite type clock
  clk: mmp: add device tree support for clocks.
It add the device tree support. The whole clock tree is not
defined in .c file, but be parsed from the device tree file.

The final part of the patches
  arm: mmp: support clock device tree for mmp platforms
Change the mmp platform to use device tree to parse the clocks.

Chao Xie (12):
  clk: mmp: add prefix "mmp" for structures defined for clk-frac
  clk: mmp: add spin lock for clk-frac
  clk: mmp: add init callback for clk-frac
  clk: mmp: move definiton of mmp_clk_frac to clk.h
  clk: mmp: add clock type mix
  clk: mmp: add mmp private gate clock
  clk: mmp: add clock type composite for mix
  clk: mmp: add clock type master
  clk: mmp: add spin lock automatic detection from device tree
  clk: mmp: add device tree support for composite type clock
  clk: mmp: add device tree support for clocks.
  arm: mmp: support clock device tree for mmp platforms

 .../devicetree/bindings/clock/mmp/clk-composite    |  58 ++
 .../devicetree/bindings/clock/mmp/clk-div          |  28 +
 .../devicetree/bindings/clock/mmp/clk-factor       |  28 +
 .../devicetree/bindings/clock/mmp/clk-gate         |  41 ++
 .../devicetree/bindings/clock/mmp/clk-master       |  47 ++
 .../devicetree/bindings/clock/mmp/clk-mix          |  38 ++
 .../devicetree/bindings/clock/mmp/clk-mux          |  20 +
 Documentation/devicetree/bindings/clock/mmp/lock   |  44 ++
 arch/arm/boot/dts/mmp2-clock.dtsi                  | 575 +++++++++++++++++
 arch/arm/boot/dts/mmp2.dtsi                        |  11 +
 arch/arm/boot/dts/pxa168-clock.dtsi                | 443 +++++++++++++
 arch/arm/boot/dts/pxa168.dtsi                      |  10 +
 arch/arm/boot/dts/pxa910-clock.dtsi                | 388 ++++++++++++
 arch/arm/boot/dts/pxa910.dtsi                      |  10 +
 arch/arm/mach-mmp/Kconfig                          |   7 +-
 arch/arm/mach-mmp/Makefile                         |   2 +-
 arch/arm/mach-mmp/common.h                         |   1 +
 arch/arm/mach-mmp/mmp-dt.c                         |  57 +-
 arch/arm/mach-mmp/mmp2-dt.c                        |  50 --
 drivers/clk/mmp/Makefile                           |   7 +-
 drivers/clk/mmp/clk-frac.c                         |  74 ++-
 drivers/clk/mmp/clk-gate.c                         | 133 ++++
 drivers/clk/mmp/clk-master-node.c                  | 195 ++++++
 drivers/clk/mmp/clk-mix-composite.c                | 195 ++++++
 drivers/clk/mmp/clk-mix.c                          | 419 +++++++++++++
 drivers/clk/mmp/clk-mmp2.c                         |   6 +-
 drivers/clk/mmp/clk-of-composite.c                 | 253 ++++++++
 drivers/clk/mmp/clk-of.c                           | 689 +++++++++++++++++++++
 drivers/clk/mmp/clk-pxa168.c                       |   6 +-
 drivers/clk/mmp/clk-pxa910.c                       |   6 +-
 drivers/clk/mmp/clk.h                              | 164 ++++-
 drivers/clk/mmp/lock.c                             | 159 +++++
 32 files changed, 4035 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/clk-composite
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/clk-div
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/clk-factor
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/clk-gate
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/clk-master
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/clk-mix
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/clk-mux
 create mode 100644 Documentation/devicetree/bindings/clock/mmp/lock
 create mode 100644 arch/arm/boot/dts/mmp2-clock.dtsi
 create mode 100644 arch/arm/boot/dts/pxa168-clock.dtsi
 create mode 100644 arch/arm/boot/dts/pxa910-clock.dtsi
 delete mode 100644 arch/arm/mach-mmp/mmp2-dt.c
 create mode 100644 drivers/clk/mmp/clk-gate.c
 create mode 100644 drivers/clk/mmp/clk-master-node.c
 create mode 100644 drivers/clk/mmp/clk-mix-composite.c
 create mode 100644 drivers/clk/mmp/clk-mix.c
 create mode 100644 drivers/clk/mmp/clk-of-composite.c
 create mode 100644 drivers/clk/mmp/clk-of.c
 create mode 100644 drivers/clk/mmp/lock.c

-- 
1.8.3.2
