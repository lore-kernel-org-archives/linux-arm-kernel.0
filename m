From: Haiying.Wang@nxp.com (Haiying Wang)
Date: Thu, 20 Apr 2017 15:34:15 -0400
Subject: [PATCH 0/3] bus: fsl-mc: dpio: udpate QMan CENA region
Message-ID: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset allows the NXP's DPAA2 QMan Software portal
CENA region to be cacheable as designed for the performance
goal. Besides, the write allocate stash feature of the QMan
requires the non-shareable attribute for this cache-enabled
memory.
So this patchset extends the arm64 ioremap with cache-enable
and non-shareable first, then enables the CENA portal memory
access in the QBMan driver, at last changes the ioremap call
in dpio driver where the software portal CENA memory is
mapped to be the correct one.

Haiying Wang (3):
  arm64: extend ioremap for cacheable non-shareable memory
  bus: fsl-mc: dpio: enable qbman CENA portal memory access
  bus: fsl-mc: dpio: change CENA regs to be cacheable

 arch/arm64/include/asm/io.h                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h          |  1 +
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c  |  6 +++---
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 23 +++++++++++++++++------
 4 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.7.4
