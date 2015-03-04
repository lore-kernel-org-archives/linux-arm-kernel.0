From: wuyun.wu@huawei.com (Yun Wu)
Date: Wed, 4 Mar 2015 11:18:13 +0800
Subject: [PATCH v3 0/5] enhance configuring an ITS
Message-ID: <1425439098-10708-1-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series makes some enhancement to ITS configuration in the
following aspects:

o make allocation of the ITS tables more sensible
o replace magic numbers with sensible macros
o guarantees a safe quiescent status before initializing an ITS

This patch series is based on Marc's branch[1], and tested on Hisilion
ARM64 board with GICv3 ITS hardware.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gic-fixes

v2 -> v3:
o drop the patch of tracing LPI enabling status since Vladimir Murzin
  had already posted a similar patch
o fix several improper description issues

v1 -> v2:
o rebase to Marc's GIC fix branch
o drop size calculation for Device Table since Marc had already posted one
o guarantees a safe quiescent status before initializing an ITS as
  Marc suggested, rather than register a reboot notifier
o fix an issue about the enabling status of LPI feature

Yun Wu (5):
  irqchip: gicv3-its: zero itt before handling to hardware
  irqchip: gicv3-its: use 64KB page as default granule
  irqchip: gicv3-its: add limitation to page order
  irqchip: gicv3-its: define macros for GITS_CTLR fields
  irqchip: gicv3-its: support safe initialization

 drivers/irqchip/irq-gic-v3-its.c   | 46 +++++++++++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic-v3.h |  3 +++
 2 files changed, 46 insertions(+), 3 deletions(-)

--
1.8.0
