From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sun, 10 Nov 2013 04:09:30 +0100
Subject: [PATCH v2 0/7] Renesas R8A7790 Common Clock Framework support
Message-ID: <1384052977-30616-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the second version of the CCF clock drivers for the Renesas R-Car
R8A7790 (H2) SoC.

The patches are pretty self-explanatory and described in their respective
commit message. The R8A7790 datasheet is unfortunately not publicly available.

The code is available in my git tree at

        git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/r8a7790

The branch is based on a merge of renesas-devel-v3.12-rc7-20131101, v3.12, and
clk-prepare patches I've posted earlier on the list (see "[PATCH 00/12] Prepare
various SH/R Mobile/Car drivers for CCF migration").

Changes compared to v1:

- The core CPG clocks driver now supports the r8a7791 SoC in addition to the
r8a7790. They are collectively refered to as 'R-Car Gen2'. The driver has thus
been renamed to clk-rcar-gen2.c. The DT bindings have been updated accordingly.

- Several MSTP clocks have been added to the r8a7790-clock.h header and a new
header has been added for the r8a7791

- The r8a7790 dtsi patches that add and reference clocks have been added to
this series.

Cc: devicetree at vger.kernel.org

Laurent Pinchart (7):
  clk: shmobile: Add R-Car Gen2 clocks support
  clk: shmobile: Add DIV6 clock support
  clk: shmobile: Add MSTP clock support
  ARM: shmobile: r8a7790: Add clock index macros for DT sources
  ARM: shmobile: r8a7791: Add clock index macros for DT sources
  ARM: shmobile: r8a7790: Add clocks
  ARM: shmobile: r8a7790: Reference clocks

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  27 ++
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 ++++
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |  32 +++
 arch/arm/boot/dts/r8a7790-lager-reference.dts      |   2 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |   2 +-
 arch/arm/boot/dts/r8a7790.dtsi                     | 310 +++++++++++++++++++++
 drivers/clk/shmobile/Makefile                      |   7 +-
 drivers/clk/shmobile/clk-div6.c                    | 185 ++++++++++++
 drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++
 drivers/clk/shmobile/clk-rcar-gen2.c               | 187 +++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h          |  99 +++++++
 include/dt-bindings/clock/r8a7791-clock.h          | 104 +++++++
 include/linux/clk/shmobile.h                       |  19 ++
 13 files changed, 1247 insertions(+), 3 deletions(-)
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
