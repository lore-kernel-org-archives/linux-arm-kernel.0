From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Nov 2013 10:18:15 +0900
Subject: [RFC 00/17] ARM: shmobile: r8a7779, marzen: multiplatform
Message-ID: <1385342312-1967-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of this series is to adding common clock framework and in turn
multiplatform support to the r8a7779 SoC and marzen-reference.  It
subsequently removes non-multiplatform support from marzen-reference.  This
last step is provided to illustrate that it can be done, it may not be
desirable to do so for some time.

This is based on work for R-Car Gen2 by Laurent Pinchart and Magnus Damm.

I expect the R-Car Gen2 work in this area to change and
I intend to update this series as necessary.


This series is based on the clocks/ccf/rcar-gen2 branch
of Laurent's fbdev tree. I expect that branch to be rebased/changed,
but it seems to be an adequate base for an RFC.

I have made this series, including its base, available
in the topic/clocks/ccf/r8a7779-marzen branch of my renesas tree.
That branch is likely to be rebased/changed in the future.


Simon Horman (17):
  clk: shmobile: r8a7779: Add clocks support
  clk: shmobile: r8a7779: Add MSTP clock support
  ARM: shmobile: r8a7779: Add clock index macros for DT sources
  ARM: shmobile: r8a7779: Add clocks
  ARM: shmobile: r8a7779: Reference clocks
  ARM: shmobile: Sync Marzen DTS with Marzen reference DTS
  ARM: shmobile: r8a7779: Sort headers alphabetically
  ARM: shmobile: r8a7779: Add helper to read mode pins
  ARM: shmobile: r8a7779: Move r8a7779_earlytimer_init to
    clock-r8a7779.c
  ARM: shmobile: marzen-reference: Move clock and OF device
    initialisation into board code
  ARM: shmobile: r8a7779: Do not include sh_clk.h in r8a7779.h
  ARM: shmobile: r8a7779: Initial multiplatform support
  ARM: shmobile: marzen-reference: Initialize CPG device
  ARM: shmobile: marzen-reference: Instantiate clkdevs for SCIF and CMT
  ARM: shmobile: Remove non-multiplatform Marzen reference support
  ARM: shmobile: Let Marzen multiplatform boot with Marzen DTB
  ARM: shmobile: Remove Marzen reference DTS

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  22 +++
 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     | 110 --------------
 arch/arm/boot/dts/r8a7779-marzen.dts               |  82 ++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     | 132 ++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |  21 +--
 arch/arm/mach-shmobile/Makefile                    |   4 +-
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-koelsch-reference.c   |   1 +
 arch/arm/mach-shmobile/board-marzen-reference.c    |  44 ++++++
 arch/arm/mach-shmobile/board-marzen.c              |  28 ++--
 arch/arm/mach-shmobile/clock-r8a7779.c             |  22 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h      |   2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |  28 ++--
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7779.c                 | 166 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7779-clock.h          |  61 ++++++++
 include/linux/clk/shmobile.h                       |   1 +
 19 files changed, 564 insertions(+), 165 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
 delete mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
 create mode 100644 drivers/clk/shmobile/clk-r8a7779.c
 create mode 100644 include/dt-bindings/clock/r8a7779-clock.h

-- 
1.8.4
