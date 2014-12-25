From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Dec 2014 16:34:16 +0800
Subject: [PATCH 0/4] ARM: add basic CSR atlas7 Auto SoC support
Message-ID: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

add basic support for CSR atlas7 new Auto SoC. this patchset only
adds debug port, dts, smp and machine for the chip.

we need some follow-up patches for clock, pinctrl, dma and so on.

Guo Zeng (1):
  ARM: sirf: add two debug ports for CSRatlas7 SoC

Zhiwu Song (3):
  ARM: sirf: add atlas7 machine support
  ARM: dts: add init dts file for CSR atlas7 SoC
  ARM: sirf: bring up SMP in atlas7 SoC

 Documentation/devicetree/bindings/arm/sirf.txt |   2 +
 arch/arm/Kconfig.debug                         |  21 +-
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/atlas7-evb.dts               | 110 ++++
 arch/arm/boot/dts/atlas7.dtsi                  | 813 +++++++++++++++++++++++++
 arch/arm/include/debug/sirf.S                  |  37 +-
 arch/arm/mach-prima2/Kconfig                   |  13 +-
 arch/arm/mach-prima2/common.c                  |  16 +-
 arch/arm/mach-prima2/lluart.c                  |  21 +-
 arch/arm/mach-prima2/platsmp.c                 |  52 +-
 10 files changed, 1022 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/boot/dts/atlas7-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas7.dtsi

-- 
2.2.0
