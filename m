From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 21 Oct 2016 15:45:58 +0300
Subject: [PATCH 0/3] clk: keystone: add sci clock support
Message-ID: <1477053961-27128-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Version 3 has following changes compared to v2 [1]:
- rebased on top of 4.9-rc1
- dropped some of the controversial DT properties like ti,ssc-clocks etc.
- driver now registers all the SCI clocks during probe time, for this,
  there is an array built-in to the driver with knowledge of valid clocks
  for the device
- xlate only picks up the clocks registered during probe

This series depends on the base SCI protocol support series [2]
and the TI-SCI generic PM domain support series for the device
ID include file [3].

Quick boot test seems to be fine.

-Tero

[1] http://www.spinics.net/lists/devicetree/msg141319.html
[2] http://www.spinics.net/lists/devicetree/msg146621.html
[3] http://www.spinics.net/lists/arm-kernel/msg536851.html

Tero Kristo (3):
  Documentation: dt: Add TI SCI clock driver
  dt-binding: clock: Add k2g clock definitions
  clk: keystone: Add sci-clk driver support

 .../devicetree/bindings/clock/ti,sci-clk.txt       |  37 ++
 MAINTAINERS                                        |   3 +
 drivers/clk/Kconfig                                |   9 +
 drivers/clk/keystone/Makefile                      |   1 +
 drivers/clk/keystone/sci-clk.c                     | 589 +++++++++++++++++++++
 include/dt-bindings/clock/k2g.h                    | 234 ++++++++
 6 files changed, 873 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 create mode 100644 drivers/clk/keystone/sci-clk.c
 create mode 100644 include/dt-bindings/clock/k2g.h

-- 
1.9.1
