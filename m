From: khilman@baylibre.com (Kevin Hilman)
Date: Wed,  7 Dec 2016 11:31:33 -0800
Subject: [PATCH v2 0/4] ARM: davinci: da850: add/enable video capture
Message-ID: <20161207193137.27947-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for VPIF video capture using DT (partially.)

The main VPIF device, and its pin muxing are using DT, but legacy
platform_data is still required for the vpif_capture driver.  Passing
legacy platform_data is required until the V4L2 framework, and
subdevice drivers (such as the tvp514x) grow a way of selecting input
and output routing (c.f. V4L2 s_routing API)

Dependencies:
- VPIF driver changes:
  [PATCH v6 0/5] davinci: VPIF: add DT support
  https://marc.info/?l=linux-arm-kernel&m=148113556200610

Kevin Hilman (4):
  ARM: dts: davinci: da850: VPIF: add node and muxing
  ARM: davinci_all_defconfig: enable video capture as modules
  ARM: davinci: da8xx: add pdata-quirks, use for VPIF capture
  ARM: davinci: board-da850-evm: add I2C ID for VPIF

 arch/arm/boot/dts/da850-evm.dts             |   6 ++
 arch/arm/boot/dts/da850-lcdk.dts            |   6 ++
 arch/arm/boot/dts/da850.dtsi                |  38 ++++++-
 arch/arm/configs/davinci_all_defconfig      |   6 ++
 arch/arm/mach-davinci/Makefile              |   2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |   1 +
 arch/arm/mach-davinci/da8xx-dt.c            |   2 +
 arch/arm/mach-davinci/include/mach/common.h |   4 +
 arch/arm/mach-davinci/pdata-quirks.c        | 155 ++++++++++++++++++++++++++++
 9 files changed, 218 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-davinci/pdata-quirks.c

-- 
2.9.3
