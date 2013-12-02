From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon,  2 Dec 2013 14:33:34 +0100
Subject: [PATCH v4 0/3] Renesas R-Car Gen2 Common Clock Framework drivers
Message-ID: <1385991214-28003-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the fourth and hopefully final version of the CCF clock drivers for
the Renesas R-Car R8A7790 (H2) and R8A7791 (M2) SoCs. I plan to send a pull
request on Wednesday to Mike Turquette and have thus rebased the patches on
top of v3.13-rc1 and removed the arch/ specific changes.

The patches are pretty self-explanatory and described in their respective
commit message. The R8A7790 and R8A7791 datasheets are unfortunately not
publicly available.

Changes compared to v3:

- Clarified the usage of the reg and clocks DT properties for the MSTP driver
- Rebased on top of v3.13-rc1
- Dropped the arch/ specific changes

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

Laurent Pinchart (3):
  clk: shmobile: Add R-Car Gen2 clocks support
  clk: shmobile: Add DIV6 clock support
  clk: shmobile: Add MSTP clock support

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  28 ++
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  51 ++++
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |  32 +++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/shmobile/Makefile                      |   7 +
 drivers/clk/shmobile/clk-div6.c                    | 185 +++++++++++++
 drivers/clk/shmobile/clk-mstp.c                    | 229 ++++++++++++++++
 drivers/clk/shmobile/clk-rcar-gen2.c               | 298 +++++++++++++++++++++
 include/linux/clk/shmobile.h                       |  19 ++
 9 files changed, 850 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/Makefile
 create mode 100644 drivers/clk/shmobile/clk-div6.c
 create mode 100644 drivers/clk/shmobile/clk-mstp.c
 create mode 100644 drivers/clk/shmobile/clk-rcar-gen2.c
 create mode 100644 include/linux/clk/shmobile.h

-- 
Regards,

Laurent Pinchart
