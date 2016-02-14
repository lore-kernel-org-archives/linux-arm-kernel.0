From: majun258@huawei.com (MaJun)
Date: Sun, 14 Feb 2016 10:16:26 +0800
Subject: [PATCH 0/5] irqchip: Add support for Hisilicon mbigen v1 chip
Message-ID: <1455416191-23616-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

This patch set is used to support the mbigen v1 chip.
Compared to mbigen v2 chip, the main difference between them is
register layout(address,format)

As a sequence of this difference, the functions used to get or calculate
register address are also changed for this reason.

I posted this driver as a independent patch set but not change the mbigen-v2
driver to support mbigen-v1 hardware.

Ma Jun (5):
  dt-binding: Change the mbigen bindding file to support the mbigen-v1
  dt-binding:Rename the mbigen binding file name
  irqchip: add platform device driver for mbigen device
  irqchip:create irq domain for each mbigen device
  irqchip:implement the mbigen irq chip operation functions

 .../interrupt-controller/hisilicon,mbigen-v2.txt   |   74 -----
 .../interrupt-controller/hisilicon,mbigen.txt      |   74 +++++
 drivers/irqchip/Makefile                           |    2 +-
 drivers/irqchip/irq-mbigen-v1.c                    |  295 ++++++++++++++++++++
 4 files changed, 370 insertions(+), 75 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen.txt
 create mode 100644 drivers/irqchip/irq-mbigen-v1.c
