From: wuyun.wu@huawei.com (Yun Wu)
Date: Fri, 30 Jan 2015 15:46:44 +0800
Subject: [PATCH 0/5] enhance configuring an ITS
Message-ID: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series makes some enhancement to ITS configuration in the
following three aspects:

o allocation of the ITS tables
o replacing magic numbers with sensible macros
o supporting ITS power down

This patch series is based on linux 3.19-rc6, and tested on Hisilion
ARM64 board with GICv3 ITS hardware.

Yun Wu (5):
  irqchip: gicv3-its: allocate proper size for DT
  irqchip: gicv3-its: zero itt before handling to hardware
  irqchip: gicv3-its: use 64KB page as default granule
  irqchip: gicv3-its: define macros for GITS_CTLR fields
  irqchip: gicv3-its: add support for power down

 drivers/irqchip/irq-gic-v3-its.c   | 90 ++++++++++++++++++++++++++++++++++----
 include/linux/irqchip/arm-gic-v3.h |  3 ++
 2 files changed, 85 insertions(+), 8 deletions(-)

--
1.8.0
