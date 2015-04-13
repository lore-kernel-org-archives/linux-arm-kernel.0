From: bintian.wang@huawei.com (Bintian Wang)
Date: Mon, 13 Apr 2015 17:17:34 +0800
Subject: [PATCH v2 0/6] arm64,hi6220: Enable Hisilicon Hi6220 SoC
Message-ID: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi6220 is one mobile solution of Hisilicon, this patchset contains
initial support for Hi6220 SoC and HiKey development board, which
supports octal ARM Cortex A53 cores. Initial support is minimal and
includes just the arch configuration, clock driver, device tree
configuration.

PSCI is enabled in device tree and there is no problem to boot all the
octal cores, but the CPU hotplug is still under development, you can
download and compile the latest firmware based on the following link
to run this patch set:
https://github.com/96boards/documentation/wiki/UEFI 

Changes v2:
* Split the DT bindings documents into earlier patches
* Change SMP enable method from spin-table to PSCI in device tree
* Remove "clock-frequency" from armv8-timer device node in device tree
* Add more description about Hisilicon designed system controllers
  in DT bindings document
* Enable high speed clock on UART1 mux
* Other changes based on the discussion in the mailing list:
  https://lkml.org/lkml/2015/2/5/147

Bintian Wang (6):
  arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
  arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
  clk: hi6220: Document devicetree bindings for hi6220 clock
  clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
  arm64: Kconfig: Add clock support to ARCH_HISI
  arm64: dts: Add dts files for Hisilicon Hi6220 SoC

 .../bindings/arm/hisilicon/hisilicon.txt           |  73 ++++++
 .../devicetree/bindings/clock/hi6220-clock.txt     |  34 +++
 arch/arm64/Kconfig                                 |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/hisilicon/Makefile             |   5 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  28 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 171 ++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/Kconfig                                |   2 +
 drivers/clk/Makefile                               |   4 +-
 drivers/clk/hisilicon/Kconfig                      |   5 +
 drivers/clk/hisilicon/Makefile                     |   3 +-
 drivers/clk/hisilicon/clk-hi6220.c                 | 292 +++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        |  29 ++
 drivers/clk/hisilicon/clk.h                        |  17 ++
 drivers/clk/hisilicon/clkdivider-hi6220.c          | 273 +++++++++++++++++++
 include/dt-bindings/clock/hi6220-clock.h           | 173 ++++++++++++
 17 files changed, 1113 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
 create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
 create mode 100644 drivers/clk/hisilicon/Kconfig
 create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
 create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
 create mode 100644 include/dt-bindings/clock/hi6220-clock.h

-- 
1.9.1
