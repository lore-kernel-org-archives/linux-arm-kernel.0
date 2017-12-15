From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Dec 2017 10:08:51 -0800
Subject: [PATCH 0/9] Update ti-sysc driver to use dts for capabilities
Message-ID: <20171215180900.3243-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are patches for review to update ti-sysc binding and driver to
get interconnect target module capabilities from device tree.

After this series I'll be posting another series to dynamically
allocate struct omap_hwmod_class_sysconfig based on device tree
data instead of the current platform data.

These patches are against v4.15-rc series with the last patch
depending on the clkctrl nodes in Linux next.

Regards,

Tony


Tony Lindgren (9):
  dt-bindings: ti-sysc: Update binding for timers and capabilities
  ARM: dts: Add generic ti,sysc compatible in addition to the custom
    ones
  ARM: OMAP2+: Move all omap_hwmod_sysc_fields to
    omap_hwmod_common_data.c
  bus: ti-sysc: Make omap_hwmod_sysc_fields into sysc_regbits platform
    data
  bus: ti-sysc: Add register bits for interconnect target modules
  bus: ti-sysc: Detect i2c interconnect target module based on register
    layout
  bus: ti-sysc: Handle module quirks based dts configuration
  bus: ti-sysc: Add parsing of module capabilities
  ARM: dts: Update ti-sysc data for existing users

 Documentation/devicetree/bindings/bus/ti-sysc.txt |  37 ++
 arch/arm/boot/dts/dra7.dtsi                       |  30 +-
 arch/arm/boot/dts/omap4.dtsi                      |  94 ++++-
 arch/arm/mach-omap2/omap_hwmod.c                  |   2 +
 arch/arm/mach-omap2/omap_hwmod.h                  |  34 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c        |  21 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c        |  17 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c         |   7 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.c      |  40 +-
 drivers/bus/ti-sysc.c                             | 485 ++++++++++++++++++++--
 include/dt-bindings/bus/ti-sysc.h                 |  22 +
 include/linux/platform_data/ti-sysc.h             |  86 ++++
 12 files changed, 758 insertions(+), 117 deletions(-)
 create mode 100644 include/dt-bindings/bus/ti-sysc.h
 create mode 100644 include/linux/platform_data/ti-sysc.h

-- 
2.15.0
