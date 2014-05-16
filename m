From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:33 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r7s72100-ccf Updates for v3.16
Message-ID: <cover.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r7s72100-ccf updates for v3.16.

This pull request is based on Renesas SoC Clock Cleanups for v3.16,
such requests, tagged as renesas-clock-cleanup2-for-v3.16,
which I have already sent a pull-request for.


This series includes dependencies that do not fit easily into the usual
inter-branch dependencies and as such I have grouped them together in a
single branch.


The following changes since commit c17fcfbcc0f6b4f3cae761149e1a6108dd6750e7:

  ARM: shmobile: r7s72100: Switch to new style MTU2 device (2014-05-11 19:35:28 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r7s72100-ccf-for-v3.16

for you to fetch changes up to 9fbb1ae01b878e2cce9626fa6fdc9e5dcefeb6b5:

  ARM: shmobile: r7s72100: use workaround for non DT-clocks (2014-05-14 11:42:55 +0900)

----------------------------------------------------------------
Renesas ARM Based r7s72100 SoC CCF Updates for v3.16

r7s72100 (RZ/A1H) SoC and its Genmai board
* Add and use CCF support
* Initislise SCIF, I2C and SPI via DT

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Add forward declaration of struct clk to silence warning

Wolfram Sang (11):
      ARM: shmobile: r7s72100: document MSTP clock support
      ARM: shmobile: r7s72100: add essential clock nodes to dtsi
      ARM: shmobile: r7s72100: genmai: populate nodes for external clocks
      ARM: shmobile: r7s72100: add scif nodes to dtsi
      ARM: shmobile: r7s72100: genmai: add uart alias and activate scif2 as console
      ARM: shmobile: r7s72100: genmai: platform scif devices only for legacy support
      ARM: shmobile: r7s72100: add i2c clocks to dtsi
      ARM: shmobile: r7s72100: remove I2C DT clocks from legacy clock support
      ARM: shmobile: r7s72100: add spi clocks to dtsi
      ARM: shmobile: r7s72100: remove SPI DT clocks from legacy clock support
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
