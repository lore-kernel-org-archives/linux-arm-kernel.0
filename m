From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 20 May 2014 08:01:33 +0200
Subject: [GIT PULL 1/2] ARM: berlin: DT changes for v3.16
Message-ID: <1400565694-1568-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

these are the DT related changes for Berlin SoCs. The first real PR after
the initial support, I hope it is not too late for v3.16.

We had some late but valuable clock binding changes that are killing my
time schedule as they had some influence on pinctrl too. Anyway, pipelining
the arm-soc PR is my last option, I either end up with a broken mach-berlin
or with useless subsystem drivers. I guess it is just the lesson I had to
learn.

Anyway, with this in, it should allow us to use a whole bunch of existing
drivers for common IP in the next cycle.

Please pull.

Thanks,
  Sebastian

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  https://github.com/shesselba/linux-berlin.git tags/berlin-dt-3.16

for you to fetch changes up to 3047086dfd5642660fd411ea5fec093bc477f009:

  ARM: dts: berlin: enable SD card reader and eMMC for the BG2Q DMP (2014-05-19 23:02:34 +0200)

----------------------------------------------------------------
Quite a lot changes but it looks like DT approach is really paying off.
BG2Q joins Berlin SoC family with corresponding development board, DW
gpio nodes for all SoCs. Most notably, we have settled clock bindings
to allow us to continue on drivers requiring clocks and pinctrl bindings.
Last but not least, BG2Q gained SDHCI support and is able to properly
boot into userspace.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: berlin: convert BG2Q to DT clock nodes

Antoine Tenart (9):
      ARM: dts: berlin: add the Marvell Armada 1500 pro
      ARM: dts: berlin: add the Marvell BG2-Q DMP device tree
      ARM: dts: berlin: add the BG2Q GPIO nodes
      ARM: dts: berlin: add the BG2 GPIO nodes
      ARM: dts: berlin: add the BG2CD GPIO nodes
      dt-binding: ARM: add pinctrl binding docs for Marvell Berlin2 SoCs
      ARM: dts: berlin: add the pinctrl node and muxing setup for uarts
      ARM: dts: berlin: add the SDHCI nodes for the BG2Q
      ARM: dts: berlin: enable SD card reader and eMMC for the BG2Q DMP

Sebastian Hesselbarth (5):
      ARM: dts: berlin: add scu and chipctrl device nodes for BG2/BG2Q
      dt-binding: ARM: add clock binding docs for Marvell Berlin2 SoCs
      clk: berlin: add binding include for Berlin SoC clock ids
      ARM: dts: berlin: convert BG2CD to DT clock nodes
      ARM: dts: berlin: convert BG2 to DT clock nodes

 .../devicetree/bindings/arm/marvell,berlin.txt     | 102 ++++++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/berlin2.dtsi                     | 191 +++++++++--
 arch/arm/boot/dts/berlin2cd.dtsi                   | 167 ++++++++--
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  39 +++
 arch/arm/boot/dts/berlin2q.dtsi                    | 363 +++++++++++++++++++++
 include/dt-bindings/clock/berlin2.h                |  45 +++
 include/dt-bindings/clock/berlin2q.h               |  31 ++
 8 files changed, 881 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/boot/dts/berlin2q-marvell-dmp.dts
 create mode 100644 arch/arm/boot/dts/berlin2q.dtsi
 create mode 100644 include/dt-bindings/clock/berlin2.h
 create mode 100644 include/dt-bindings/clock/berlin2q.h
