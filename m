From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 23 Aug 2013 10:33:58 +0800
Subject: [PATCH v2 0/4] arm: mvebu: fix resource leak
Message-ID: <1377225242-5854-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches try to fix resource leak by adding missing of_node_put(),
iounmap or using devm_ioremap_resource() if available.

v2:
  - use devm_ioremap_resource() as suggested by Ezequiel Garcia
  - use gates_out instead of bail_out as suggested by Mike Turquette

Jisheng Zhang (4):
  arm: mvebu: add missing of_node_put() to fix reference leak
  bus: mvebu: add missing of_node_put() to fix reference leak
  clk: mvebu: add missing iounmap
  pinctrl: mvebu: Convert to use devm_ioremap_resource

 arch/arm/mach-mvebu/armada-370-xp.c     |  1 +
 arch/arm/mach-mvebu/coherency.c         |  8 +++++++-
 arch/arm/mach-mvebu/platsmp.c           |  1 +
 arch/arm/mach-mvebu/pmsu.c              |  1 +
 arch/arm/mach-mvebu/system-controller.c |  1 +
 drivers/bus/mvebu-mbus.c                |  6 +++++-
 drivers/clk/mvebu/clk-cpu.c             |  4 +++-
 drivers/clk/mvebu/common.c              | 18 ++++++++++++------
 drivers/pinctrl/mvebu/pinctrl-mvebu.c   | 11 +++++------
 9 files changed, 36 insertions(+), 15 deletions(-)

-- 
1.8.4.rc3
