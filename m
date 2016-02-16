From: majun258@huawei.com (MaJun)
Date: Tue, 16 Feb 2016 14:37:23 +0800
Subject: [PATCH v2 0/5] irqchip: Add support for Hisilicon mbigen v1 chip
Message-ID: <1455604648-20668-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

This patch set is used to support the mbigen v1 chip.
Compared to mbigen v2 chip, the main difference between them is
register layout(address,format)

As a sequence of this difference, the functions used to get or calculate
register address are also changed for this reason.

Changes in v2:
--- Fixed the build test error when applied patch v1 3/5

Ma Jun (5):
  dt-binding: Change the mbigen binding file to support the mbigen-v1
  dt-binding:Rename the mbigen binding file name
  irqchip: add platform device driver for mbigen device
  irqchip:create irq domain for each mbigen device
  irqchip:implement the mbigen irq chip operation functions

 .../interrupt-controller/hisilicon,mbigen-v2.txt   |   74 -----
 .../interrupt-controller/hisilicon,mbigen.txt      |   74 +++++
 drivers/irqchip/Makefile                           |    2 +-
 drivers/irqchip/irq-mbigen-v1.c                    |  287 ++++++++++++++++++++
 4 files changed, 362 insertions(+), 75 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen.txt
 create mode 100644 drivers/irqchip/irq-mbigen-v1.c
