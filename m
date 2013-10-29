From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 15:55:08 +0100
Subject: [PATCH 0/3] Renesas R8A7790 Common Clock Framework support
Message-ID: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds CCF drivers for the clocks found in the Renesas R-Car
R8A7790 (H2) SoC.

The patches are pretty self-explanatory and described in their respective
commit message. The R8A7790 datasheet is unfortunately not publicly available.

The code is available in my git tree at

	git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/r8a7790

The branch is based on a merge of renesas-devel-20131016, v3.12-rc7 and
multiarch drivers and clk-prepare patches I've posted earlier today. A full
DT description of the R8A7790 clocks is available in the clocks/ccf/lager
branch of the same repository (see "ARM: shmobile: r8a7790: Add clocks" and
"ARM: shmobile: r8a7790: Reference clocks" patches).

Laurent Pinchart (3):
  clk: shmobile: Add DIV6 clock support
  clk: shmobile: Add MSTP clock support
  clk: shmobile: Add R8A7790 clocks support

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  27 +++
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 +++++
 .../bindings/clock/renesas,r8a7790-cpg-clocks.txt  |  26 +++
 drivers/clk/shmobile/Makefile                      |   6 +-
 drivers/clk/shmobile/clk-div6.c                    | 185 +++++++++++++++++
 drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++++++++
 drivers/clk/shmobile/clk-r8a7790.c                 | 176 ++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h          |  66 ++++++
 include/linux/clk/shmobile.h                       |  19 ++
 9 files changed, 780 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-div6.c
 create mode 100644 drivers/clk/shmobile/clk-mstp.c
 create mode 100644 drivers/clk/shmobile/clk-r8a7790.c
 create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
 create mode 100644 include/linux/clk/shmobile.h

-- 
Regards,

Laurent Pinchart
