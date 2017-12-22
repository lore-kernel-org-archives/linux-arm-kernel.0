From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Dec 2017 10:14:25 -0800
Subject: [GIT PULL 2/4] driver changes for ti-sysc for v4.16
In-Reply-To: <pull-1513966338-859035@atomide.com>
References: <pull-1513966338-859035@atomide.com>
Message-ID: <pull-1513966338-859035@atomide.com-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/ti-sysc-signed

for you to fetch changes up to c5a2de97fbd2979fab291fb048084d3fddd322dd:

  bus: ti-sysc: Add parsing of module capabilities (2017-12-21 07:28:54 -0800)

----------------------------------------------------------------
TI sysc driver updates for v4.16 merge window

We now have gotten ti-sysc driver to the point where it can parse
interconnect target configuration from device tree instead of the
legacy platform data. This series updates the device tree binding
and adds parsing to the driver for quirks and capabilities.

----------------------------------------------------------------
Tony Lindgren (8):
      dt-bindings: ti-sysc: Update binding for timers and capabilities
      ARM: dts: Add generic ti,sysc compatible in addition to the custom ones
      ARM: OMAP2+: Move all omap_hwmod_sysc_fields to omap_hwmod_common_data.c
      bus: ti-sysc: Make omap_hwmod_sysc_fields into sysc_regbits platform data
      bus: ti-sysc: Add register bits for interconnect target modules
      bus: ti-sysc: Detect i2c interconnect target module based on register layout
      bus: ti-sysc: Handle module quirks based dts configuration
      bus: ti-sysc: Add parsing of module capabilities

 Documentation/devicetree/bindings/bus/ti-sysc.txt |  37 ++
 arch/arm/boot/dts/dra7.dtsi                       |   4 +-
 arch/arm/boot/dts/omap4.dtsi                      |  20 +-
 arch/arm/mach-omap2/omap_hwmod.c                  |   2 +
 arch/arm/mach-omap2/omap_hwmod.h                  |  34 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c        |  21 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c        |  17 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c         |   7 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.c      |  40 +-
 drivers/bus/ti-sysc.c                             | 485 ++++++++++++++++++++--
 include/dt-bindings/bus/ti-sysc.h                 |  22 +
 include/linux/platform_data/ti-sysc.h             |  86 ++++
 12 files changed, 666 insertions(+), 109 deletions(-)
 create mode 100644 include/dt-bindings/bus/ti-sysc.h
 create mode 100644 include/linux/platform_data/ti-sysc.h
