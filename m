From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 03:10:04 +0200
Subject: [PATCH v6 00/12] CCF support for Renesas r7s72100
Message-ID: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves the r7s72100 platfrom from the legacy clock implementation to
the common clock framework.

This series has been tested with the renesas-devel-v3.15-rc2-20140428 tag. If
you want to boot into a console, you have a runtime dependency [1] which is
expected to go away in 3.15-rc6.

Changes since V5:

* rebased and tested against latest renesas/devel-tag
  (with and without CCF)
* added acks
* added the patch from Geert, and folded another into the series

PS: A tree can be found here with this series and the dependency patch:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf

[1] http://www.spinics.net/lists/linux-sh/msg30918.html (clk: shmobile: clk-mstp: change to using clock-indices)

Geert Uytterhoeven (1):
  ARM: shmobile: Add forward declaration of struct clk to silence
    warning

Wolfram Sang (11):
  ARM: shmobile: r7s72100: document MSTP clock support
  ARM: shmobile: r7s72100: add essential clock nodes to dtsi
  ARM: shmobile: r7s72100: genmai: populate nodes for external clocks
  ARM: shmobile: r7s72100: add scif nodes to dtsi
  ARM: shmobile: r7s72100: genmai: add uart alias and activate scif2 as
    console
  ARM: shmobile: r7s72100: genmai: platform scif devices only for legacy
    support
  ARM: shmobile: r7s72100: add i2c clocks to dtsi
  ARM: shmobile: r7s72100: remove I2C DT clocks from legacy clock
    support
  ARM: shmobile: r7s72100: add spi clocks to dtsi
  ARM: shmobile: r7s72100: remove SPI DT clocks from legacy clock
    support
  ARM: shmobile: r7s72100: use workaround for non DT-clocks

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 arch/arm/boot/dts/r7s72100-genmai-reference.dts    |  19 +-
 arch/arm/boot/dts/r7s72100.dtsi                    | 215 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-genmai-reference.c    |  14 +-
 arch/arm/mach-shmobile/board-genmai.c              |  44 +++++
 arch/arm/mach-shmobile/clock-r7s72100.c            |   9 -
 arch/arm/mach-shmobile/include/mach/clock.h        |   1 +
 arch/arm/mach-shmobile/setup-r7s72100.c            |  43 -----
 include/dt-bindings/clock/r7s72100-clock.h         |  41 ++++
 9 files changed, 331 insertions(+), 56 deletions(-)
 create mode 100644 include/dt-bindings/clock/r7s72100-clock.h

-- 
1.9.2
