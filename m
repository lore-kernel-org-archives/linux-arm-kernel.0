From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 19 Nov 2013 15:45:39 +0100
Subject: [PATCH v3 0/8] Renesas R-Car Gen2 Common Clock Framework support
Message-ID: <1384872347-11724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the third version of the CCF clock drivers for the Renesas R-Car
R8A7790 (H2) and R8A7791 (M2) SoCs.

The patches are pretty self-explanatory and described in their respective
commit message. The R8A7790 and R8A7791 datasheets are unfortunately not
publicly available.

The code is available in my git tree at

        git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/rcar-gen2

The branch is based on the clk-prepare patches I've posted earlier on the list
("[PATCH 00/12] Prepare various SH/R Mobile/Car drivers for CCF migration"),
themselves rebased on top of renesas-devel-v3.12-20131119.

Changes compared to v2:

- Fixed I2C MSTP clocks parents (hp -> p)
- Added Z and Z2 clocks
- Added r8a7791 clocks to DT

Changes compared to v1:

- The core CPG clocks driver now supports the r8a7791 SoC in addition to the
r8a7790. They are collectively refered to as 'R-Car Gen2'. The driver has thus
been renamed to clk-rcar-gen2.c. The DT bindings have been updated accordingly.
- Several MSTP clocks have been added to the r8a7790-clock.h header and a new
header has been added for the r8a7791
- The r8a7790 dtsi patches that add and reference clocks have been added to
this series.

Cc: devicetree at vger.kernel.org

Laurent Pinchart (8):
  clk: shmobile: Add R-Car Gen2 clocks support
  clk: shmobile: Add DIV6 clock support
  clk: shmobile: Add MSTP clock support
  ARM: shmobile: r8a7790: Add clock index macros for DT sources
  ARM: shmobile: r8a7791: Add clock index macros for DT sources
  ARM: shmobile: r8a7790: Add clocks
  ARM: shmobile: r8a7790: Reference clocks
  ARM: shmobile: r8a7791: Add clocks

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  28 ++
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  48 +++
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |  32 ++
 arch/arm/boot/dts/r8a7790.dtsi                     | 326 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi                     | 312 ++++++++++++++++++++
 drivers/clk/shmobile/Makefile                      |   7 +-
 drivers/clk/shmobile/clk-div6.c                    | 185 ++++++++++++
 drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++
 drivers/clk/shmobile/clk-rcar-gen2.c               | 298 +++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h          | 100 +++++++
 include/dt-bindings/clock/r8a7791-clock.h          | 105 +++++++
 include/linux/clk/shmobile.h                       |  19 ++
 12 files changed, 1688 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-div6.c
 create mode 100644 drivers/clk/shmobile/clk-mstp.c
 create mode 100644 drivers/clk/shmobile/clk-rcar-gen2.c
 create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
 create mode 100644 include/dt-bindings/clock/r8a7791-clock.h
 create mode 100644 include/linux/clk/shmobile.h

-- 
Regards,

Laurent Pinchart
