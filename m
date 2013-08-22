From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 22 Aug 2013 20:46:47 +0800
Subject: [PATCH 0/4] arm: mvebu: add missing of_node_put and iounmap
Message-ID: <1377175611-4241-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add missing of_node_put() to fix reference leak or
iounmap in setup/probe error path.

Jisheng Zhang (4):
  arm: mvebu: add missing of_node_put() to fix reference leak
  bus: mvebu: add missing of_node_put() to fix reference leak
  clk: mvebu: add missing iounmap
  pinctrl: mvebu: add missing iounmap

 arch/arm/mach-mvebu/armada-370-xp.c     |  1 +
 arch/arm/mach-mvebu/coherency.c         |  8 +++++++-
 arch/arm/mach-mvebu/platsmp.c           |  1 +
 arch/arm/mach-mvebu/pmsu.c              |  1 +
 arch/arm/mach-mvebu/system-controller.c |  1 +
 drivers/bus/mvebu-mbus.c                |  6 +++++-
 drivers/clk/mvebu/clk-cpu.c             |  4 +++-
 drivers/clk/mvebu/common.c              | 18 ++++++++++++------
 drivers/pinctrl/mvebu/pinctrl-mvebu.c   | 24 +++++++++++++++++-------
 9 files changed, 48 insertions(+), 16 deletions(-)

-- 
1.8.4.rc3
