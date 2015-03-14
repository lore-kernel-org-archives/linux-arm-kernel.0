From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 14 Mar 2015 19:49:35 +0800
Subject: [PATCH 00/10] ZTE platform basic support
Message-ID: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch serial add basic support to ZTE ZX296702
platform.

Jun Nie (10):
  ARM: zx: add basic support of ZTE ZX296702
  ARM: zx: add low level debug support
  MAINTAINERS: add entry for ZTE ARM architecture
  ARM: zx: add initial L2CC initialization
  ARM: zx: bring up the secondary core
  ARM: zx: add cpu hotplug support
  dt/binding: Document ZTE zx296702 devicetree
  ARM: dts: zx: add an initial dts for zx296702
  ARM: zx: Add basic defconfig support to ZX296702
  clk: zx: add zx296702 clock support

 Documentation/devicetree/bindings/arm/zte.txt      |   9 +
 .../devicetree/bindings/clock/zx296702-clk.txt     |  35 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  10 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  12 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/zx296702-ad1.dts                 |  43 ++
 arch/arm/boot/dts/zx296702.dtsi                    | 127 +++++
 arch/arm/configs/zx_defconfig                      | 129 +++++
 arch/arm/include/debug/zx.S                        |  35 ++
 arch/arm/mach-zx/Kconfig                           |  21 +
 arch/arm/mach-zx/Makefile                          |   3 +
 arch/arm/mach-zx/core.h                            |  18 +
 arch/arm/mach-zx/headsmp.S                         |  38 ++
 arch/arm/mach-zx/hotplug.c                         | 108 ++++
 arch/arm/mach-zx/platsmp.c                         | 150 +++++
 arch/arm/mach-zx/zx296702.c                        |  65 +++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zte/Makefile                           |   2 +
 drivers/clk/zte/clk-pll.c                          | 211 +++++++
 drivers/clk/zte/clk-zx296702.c                     | 611 +++++++++++++++++++++
 drivers/clk/zte/clk.h                              |  30 +
 include/dt-bindings/clock/zx296702-clock.h         | 158 ++++++
 25 files changed, 1821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt
 create mode 100644 arch/arm/boot/dts/zx296702-ad1.dts
 create mode 100644 arch/arm/boot/dts/zx296702.dtsi
 create mode 100644 arch/arm/configs/zx_defconfig
 create mode 100644 arch/arm/include/debug/zx.S
 create mode 100644 arch/arm/mach-zx/Kconfig
 create mode 100644 arch/arm/mach-zx/Makefile
 create mode 100644 arch/arm/mach-zx/core.h
 create mode 100644 arch/arm/mach-zx/headsmp.S
 create mode 100644 arch/arm/mach-zx/hotplug.c
 create mode 100644 arch/arm/mach-zx/platsmp.c
 create mode 100644 arch/arm/mach-zx/zx296702.c
 create mode 100644 drivers/clk/zte/Makefile
 create mode 100644 drivers/clk/zte/clk-pll.c
 create mode 100644 drivers/clk/zte/clk-zx296702.c
 create mode 100644 drivers/clk/zte/clk.h
 create mode 100644 include/dt-bindings/clock/zx296702-clock.h

-- 
1.9.1
