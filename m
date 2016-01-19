From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 19 Jan 2016 14:51:31 +0000
Subject: [RFC 0/9] Allow modifications of specific clocks via DT and more
Message-ID: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patch series (which requires the patch-series-v4 of
"clk: bcm2835: add clocks and add MASH support") allows to configure
specific aspects (mostly with regards to clock selection) of individual
clocks to get configured via the device-tree.

Also - for debug purposes - a patch has been added that exposes the
raw clock registers read-only via debugfs.

Martin Sperl (9):
  clk: bcm2835: add basic device tree support for per clock settings
  clk: bcm2835: add support for parent selection in DT
  clk: bcm2835: add ability to control mash level via device-tree
  clk: bcm2835: reorganize bcm2835_clock_determine_rate
  clk: bcm2835: prefer clocks that use integer dividers
  clk: bcm2835: allow to define a minimum fractional divider in DT
  clk: bcm2835: allow clock choosing mechanims to be selected in DT
  dt-bindings: bcm2835: document optional per clock dt-nodes
  clk: bcm2835: expose raw clock-registers via debugfs

 .../bindings/clock/brcm,bcm2835-cprman.txt         |   33 ++
 drivers/clk/bcm/clk-bcm2835.c                      |  508 ++++++++++++++++++--
 include/dt-bindings/clock/bcm2835.h                |   15 +
 3 files changed, 512 insertions(+), 44 deletions(-)

-- 
1.7.10.4
