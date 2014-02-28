From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Feb 2014 22:09:24 +0100
Subject: [PATCH 0/4] CCF support for Renesas r7s72100
Message-ID: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves the r7s72100 platfrom from the legacy clock implementation to
the common clock framework. Only the essential clocks are added in this series,
and other clocks will be added incrementally once the basic stuff is accepted.

This series has been tested with the renesas-devel-v3.14-rc4-20140227 tag. It
has a build dependency [1] because it uses the clkdev workaround. If you want
to boot into a console, you also have a runtime dependency [2]. A git branch
can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf

[1] http://www.spinics.net/lists/arm-kernel/msg310279.html (ARM: shmobile: Introduce shmobile_clk_workaround())
[2] http://lkml.org/lkml/2014/2/20/205 ([PATCH V7 0/3] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits)


Wolfram Sang (4):
  ARM: r7s72100: add clock nodes to dtsi
  ARM: r7s72100: genmai: populate extal clock node
  clk: shmobile: add CPG driver for rz-platforms
  ARM: shmobile: r7s72100: use workaround for non DT-clocks

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   4 +
 arch/arm/boot/dts/r7s72100.dtsi                 |  78 ++++++++++++++++-
 arch/arm/mach-shmobile/board-genmai-reference.c |  15 +++-
 drivers/clk/shmobile/Makefile                   |   1 +
 drivers/clk/shmobile/clk-rz.c                   | 112 ++++++++++++++++++++++++
 include/dt-bindings/clock/r7s72100-clock.h      |  25 ++++++
 6 files changed, 232 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/shmobile/clk-rz.c
 create mode 100644 include/dt-bindings/clock/r7s72100-clock.h

-- 
1.8.5.1
