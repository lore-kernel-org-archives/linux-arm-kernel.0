From: robherring2@gmail.com (Rob Herring)
Date: Sat, 07 Jul 2012 12:03:21 -0500
Subject: [GIT PULL] DT clk binding support for 3.6
Message-ID: <4FF86BD9.3050805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Please pull DT clk binding and highbank clk support for 3.6. The only
real change from 3.5 pull request is returning error values rather than
NULL to align with the rest of the clk framework. There's been a little
discussion but otherwise has been quiet.

Rob

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git clk-for-3.6

for you to fetch changes up to 39a8e38a03823c3acaec02c6d7c551e268cb2139:

  clk: add highbank clock support (2012-07-01 17:04:45 -0500)

----------------------------------------------------------------
Grant Likely (2):
      clk: add DT clock binding support
      clk: add DT fixed-clock binding support

Rob Herring (2):
      dt: add clock binding doc to primecell bindings
      clk: add highbank clock support

 .../devicetree/bindings/arm/primecell.txt          |    6 +
 .../devicetree/bindings/clock/calxeda.txt          |   17 +
 .../devicetree/bindings/clock/clock-bindings.txt   |  117 +++++++
 .../devicetree/bindings/clock/fixed-clock.txt      |   21 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/highbank.dts                     |   91 +++++-
 arch/arm/mach-highbank/Makefile                    |    2 +-
 arch/arm/mach-highbank/clock.c                     |   62 ----
 arch/arm/mach-highbank/highbank.c                  |    7 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-fixed-rate.c                       |   23 ++
 drivers/clk/clk-highbank.c                         |  345
++++++++++++++++++++
 drivers/clk/clk.c                                  |  140 ++++++++
 drivers/clk/clkdev.c                               |   77 +++++
 include/linux/clk-provider.h                       |   16 +
 include/linux/clk.h                                |   19 ++
 16 files changed, 881 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 create mode 100644
Documentation/devicetree/bindings/clock/clock-bindings.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-clock.txt
 delete mode 100644 arch/arm/mach-highbank/clock.c
 create mode 100644 drivers/clk/clk-highbank.c
