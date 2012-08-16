From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 16 Aug 2012 11:08:40 +0800
Subject: [PATCH V3 0/5] clk: mmp: add clock framework for mmp
Message-ID: <1345086525-12328-1-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

v1->v2:
replace __raw_xxx with xxx_relax
use ioremap to remap the registers. Finaly it will use device tree to
get the physical address.
do not use macro to register clocks, and directly call the functions.

v2->v3:
pxa910 will have APB extension clock, so some peripharals will have
clocks in APB extension base.
change pxa168-pwm to be pxa910-pwm for pxa910. It will fit the current
pwm driver.

Chao Xie (5):
  clk: mmp: add mmp specific clocks
  clk: mmp: add clock definition for pxa168
  clk: mmp: add clock definition for pxa910
  clk: mmp: add clock definition for mmp2
  arm: mmp: make all SOCs use common clock by default

 arch/arm/mach-mmp/Kconfig    |    3 +
 drivers/clk/Makefile         |    3 +
 drivers/clk/mmp/Makefile     |    9 +
 drivers/clk/mmp/clk-apbc.c   |  152 ++++++++++++
 drivers/clk/mmp/clk-apmu.c   |   97 ++++++++
 drivers/clk/mmp/clk-frac.c   |  153 ++++++++++++
 drivers/clk/mmp/clk-mmp2.c   |  544 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mmp/clk-pxa168.c |  414 ++++++++++++++++++++++++++++++++
 drivers/clk/mmp/clk-pxa910.c |  361 ++++++++++++++++++++++++++++
 drivers/clk/mmp/clk.h        |   35 +++
 10 files changed, 1771 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/mmp/Makefile
 create mode 100644 drivers/clk/mmp/clk-apbc.c
 create mode 100644 drivers/clk/mmp/clk-apmu.c
 create mode 100644 drivers/clk/mmp/clk-frac.c
 create mode 100644 drivers/clk/mmp/clk-mmp2.c
 create mode 100644 drivers/clk/mmp/clk-pxa168.c
 create mode 100644 drivers/clk/mmp/clk-pxa910.c
 create mode 100644 drivers/clk/mmp/clk.h
