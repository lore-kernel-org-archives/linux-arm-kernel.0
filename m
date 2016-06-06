From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon,  6 Jun 2016 00:40:31 -0500
Subject: [PATCH V4 0/5] Add two-level support for ITS device table
Message-ID: <1465191636-6823-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains necessary code changes to support two-level
(Indirection) table walk feature for device table.

Shanker Donthineni (5):
  irqchip/gicv3-its: Introduce two helper functions for accessing BASERn
  irqchip/gicv3-its: Add a new function for parsing device table BASERn
  irqchip/gicv3-its: Split its_alloc_tables() into two functions
  irqchip/gicv3-its: Remove an unused argument 'node_name'
  irqchip/gicv3-its: Implement two-level(indirect) device table support

 drivers/irqchip/irq-gic-v3-its.c   | 414 +++++++++++++++++++++++--------------
 include/linux/irqchip/arm-gic-v3.h |   4 +
 2 files changed, 266 insertions(+), 152 deletions(-)

-- 
This patchset created on top of Marc Zyngier's branch https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/irqchip-4.7-rc1

I have tested the Indirection feature on Qualcomm Technologies QDF2XXX server platform. See the below ITS driver log mesaages.
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] ITS at 0x00000000397e0000
[    0.000000] ITS at 0x00000000397e0000: allocated 524288 Devices @47c0400000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS at 0x00000000397e0000: allocated 8192 Interrupt Collections @47c0050000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] ITS at 0x00000000397e0000: allocated 8192 Virtual CPUs @47c0060000 (flat, esz 8, psz 64K, shr 1)

Changes since v3:
  Added pathces 1/5, 2/5 and 4/5.

Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
