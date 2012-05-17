From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 May 2012 21:02:15 -0500
Subject: [PATCH v2 0/2] Highbank clock support using DT
Message-ID: <1337220137-31666-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series adds clock support to highbank using common clock
infrastructure and DT clock bindings. The DT clock bindings were previously
posted here:

https://lkml.org/lkml/2012/4/9/322

Changes in this version:
- add Documentation for bindings
- rebase to clk-next
- add A9 periphclk divider handling instead of hardcoding
- a fix to the PLL relock sequence

Mike, It's getting a bit late, but I could not get back to this sooner. I
intend to send this and the DT patches by the end of the week.

Rob

Rob Herring (2):
  dt: add clock binding doc to primecell bindings
  clk: add highbank clock support

 .../devicetree/bindings/arm/primecell.txt          |    6 +
 .../devicetree/bindings/clock/calxeda.txt          |   17 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/highbank.dts                     |   91 +++++-
 arch/arm/mach-highbank/Makefile                    |    2 +-
 arch/arm/mach-highbank/clock.c                     |   62 ----
 arch/arm/mach-highbank/highbank.c                  |    7 +
 drivers/clk/Makefile                               |    4 +-
 drivers/clk/clk-highbank.c                         |  345 ++++++++++++++++++++
 9 files changed, 470 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 delete mode 100644 arch/arm/mach-highbank/clock.c
 create mode 100644 drivers/clk/clk-highbank.c

-- 
1.7.9.5
