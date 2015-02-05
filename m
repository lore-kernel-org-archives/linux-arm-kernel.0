From: bintian.wang@huawei.com (Bintian Wang)
Date: Thu, 5 Feb 2015 17:24:34 +0800
Subject: [PATCH 0/3] arm64,hi6220: Enable Hisilicon Hi6220 SoC
Message-ID: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Hi6220 is one mobile solution of Hisilicon, this patchset contains
initial support for Hi6220 SoC and HiKey development board, which
is based on ARM Cortex A53 architecture. Initial support is minimal
and includes just the arch configuration, clock driver, device tree
configuration. 

Many peripheral drivers will be submitted later.

Any comments will be appreciated!

Thanks,  

Bintian Wang (3):
  arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
  clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
  arm64: dts: Add dts files for Hisilicon Hi6220 SoC

 .../bindings/arm/hisilicon/hisilicon.txt           |   33 +++
 .../devicetree/bindings/clock/hi6220-clock.txt     |   30 +++
 arch/arm64/Kconfig                                 |    6 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/hisilicon/Makefile             |    5 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   31 +++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  204 ++++++++++++++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/Kconfig                                |    2 +
 drivers/clk/Makefile                               |    4 +-
 drivers/clk/hisilicon/Kconfig                      |    5 +
 drivers/clk/hisilicon/Makefile                     |    1 +
 drivers/clk/hisilicon/clk-hi6220.c                 |  284 ++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        |   29 ++
 drivers/clk/hisilicon/clk.h                        |   17 ++
 drivers/clk/hisilicon/clkdivider-hi6220.c          |  273 +++++++++++++++++++
 include/dt-bindings/clock/hi6220-clock.h           |  172 ++++++++++++
 17 files changed, 1095 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
 create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
 create mode 100644 drivers/clk/hisilicon/Kconfig
 create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
 create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
 create mode 100644 include/dt-bindings/clock/hi6220-clock.h

-- 
1.7.9.5
