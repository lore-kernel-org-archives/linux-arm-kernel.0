From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 27 Aug 2013 12:41:13 +0800
Subject: [PATCH v5 0/3] arm: mvebu: fix resource leak
Message-ID: <1377578476-3268-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches try to fix resource leak by adding missing of_node_put(),
iounmap or using devm_ioremap_resource() if available.

v5:
  - rebase against mvebu/fixes-non-critical

v4:
  - re-generate since Ezequiel's patches add DT support to the
mvebu-mbus driver

v3:
  - remove the clk patch since it's already taken by Mike
  - Add more commit log as suggested by Ezequiel Garcia

v2:
  - use devm_ioremap_resource() as suggested by Ezequiel Garcia
  - use gates_out instead of bail_out as suggested by Mike Turquette

Jisheng Zhang (3):
  arm: mvebu: add missing of_node_put() to fix reference leak
  bus: mvebu: add missing of_node_put() to fix reference leak
  pinctrl: mvebu: Convert to use devm_ioremap_resource

 arch/arm/mach-mvebu/armada-370-xp.c     |  1 +
 arch/arm/mach-mvebu/coherency.c         |  8 +++++++-
 arch/arm/mach-mvebu/platsmp.c           |  1 +
 arch/arm/mach-mvebu/pmsu.c              |  1 +
 arch/arm/mach-mvebu/system-controller.c |  1 +
 drivers/bus/mvebu-mbus.c                |  6 +++++-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c   | 11 +++++------
 7 files changed, 21 insertions(+), 8 deletions(-)

-- 
1.8.4.rc3
