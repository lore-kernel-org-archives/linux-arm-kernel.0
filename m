From: wuyun.wu@huawei.com (Yun Wu)
Date: Sun, 15 Feb 2015 17:31:57 +0800
Subject: [PATCH v2 0/6] enhance configuring an ITS
Message-ID: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series makes some enhancement to ITS configuration in the
following aspects:

o allocation of the ITS tables
o replacing magic numbers with sensible macros
o guarantees a safe quiescent status before initializing an ITS
o judging enabling status of LPI feature

This patch series is based on Marc's branch[1], and tested on Hisilion
ARM64 board with GICv3 ITS hardware.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gic-fixes

v1 -> v2:
o rebase to Marc's GIC fix branch
o drop DT size calculation part since Marc had already posted one
o guarantees a safe quiescent status before initializing an ITS as
  Marc suggested, rather than register a reboot notifier
o fix an issue about the enabling status of LPI feature

Yun Wu (6):
  irqchip: gicv3-its: zero itt before handling to hardware
  irqchip: gicv3-its: use 64KB page as default granule
  irqchip: gicv3-its: limit order of DT size to MAX_ORDER
  irqchip: gicv3-its: define macros for GITS_CTLR fields
  irqchip: gicv3-its: add support for power down
  irqchip: gicv3: skip ITS init when no ITS available

 drivers/irqchip/irq-gic-v3-its.c   | 44 +++++++++++++++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3.c       | 18 ++++++++--------
 include/linux/irqchip/arm-gic-v3.h |  3 +++
 3 files changed, 53 insertions(+), 12 deletions(-)

--
1.8.0
