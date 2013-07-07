From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Sun, 07 Jul 2013 17:14:19 +0530
Subject: [PATCH 0/3] Add clk driver to register s2mps11 clocks
Message-ID: <1373197462-4033-1-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support to register three(AP/CP/BT) buffered 32.768 KHz
outputs of mfd-s2mps11 with common clock framework and removes clocks from
regulators list.

Yadwinder Singh Brar (3):
  clk: s2mps11: Add support for s2mps11
  mfd: sec: Add clock cell for s2mps11
  mfd: s2mps11: Remove clocks from regulators list

 Documentation/devicetree/bindings/mfd/s2mps11.txt |   20 ++
 drivers/clk/Kconfig                               |    6 +
 drivers/clk/Makefile                              |    1 +
 drivers/clk/clk-s2mps11.c                         |  273 +++++++++++++++++++++
 drivers/mfd/sec-core.c                            |    4 +-
 include/linux/mfd/samsung/s2mps11.h               |    6 +-
 6 files changed, 304 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/clk-s2mps11.c
