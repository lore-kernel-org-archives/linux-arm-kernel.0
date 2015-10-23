From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Oct 2015 13:01:48 -0700
Subject: [PATCH v3 0/4] Add __ioread32_copy() and use it
Message-ID: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMD driver is reading and writing chunks of data to iomem,
and there's an __iowrite32_copy() function for the writing part, but
no __ioread32_copy() function for the reading part. This series
adds __ioread32_copy() and uses it in two places.

This is a respin with some small fixes found with soaking in -next.

Andrew, the patches should apply cleanly to linux-next, so I hope
you can pick them up directly now, instead of the previous plan where
they would go through Andy's tree.

Changes from v2:
 * Make bcm patch actually compile
 * Add new patch for frv to avoid warnings

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafa? Mi?ecki <zajec5@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: linux-mips at linux-mips.org
Cc: David Howells <dhowells@redhat.com>
Cc: linux-soc at vger.kernel.org

Stephen Boyd (4):
  frv: io: Accept const void pointers for read{b,w,l}()
  lib: iomap_copy: Add __ioread32_copy()
  soc: qcom: smd: Use __ioread32_copy() instead of open-coding it
  FIRMWARE: bcm47xx_nvram: Use __ioread32_copy() instead of open-coding

 arch/frv/include/asm/io.h                 | 17 ++++++++++++++---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 11 +++--------
 drivers/soc/qcom/smd.c                    | 13 ++++---------
 include/linux/io.h                        |  1 +
 lib/iomap_copy.c                          | 21 +++++++++++++++++++++
 5 files changed, 43 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
