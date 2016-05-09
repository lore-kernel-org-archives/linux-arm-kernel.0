From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon,  9 May 2016 15:58:24 -0500
Subject: [PATCH V3 0/2] Add two-level support to ITS device table
Message-ID: <1462827506-23570-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains necessary code changes to support two-level
(Indirection) table walk feature for device table.

Shanker Donthineni (2):
  irqchip/gicv3-its: split its_alloc_tables() into two functions
  irqchip/gicv3-its: Implement two-level(indirect) device table support

 drivers/irqchip/irq-gic-v3-its.c   | 351 +++++++++++++++++++++++--------------
 include/linux/irqchip/arm-gic-v3.h |   3 +
 2 files changed, 223 insertions(+), 131 deletions(-)

-- 

This patch is based on Marc Zyngier's branch https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/irqchip-4.7

I have tested the Indirection feature on Qualcomm Technologies QDF2XXX server platform.

Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
