From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Sep 2015 12:41:26 -0700
Subject: [PATCH 0/3] Add __ioread32_copy() and use it
Message-ID: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMD driver is reading and writing chunks of data to iomem,
and there's an __iowrite32_copy() function for the writing part, but
no __ioread32_copy() function for the reading part. This series
adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
case this should go through the -mm tree. Otherwise the target
of this patch series is SMD, so I've sent it to Andy.

Stephen Boyd (3):
  lib: iomap_copy: Add __ioread32_copy()
  soc: qcom: smd: Use __ioread32_copy() instead of open-coding it
  FIRMWARE: bcm47xx_nvram: Use __ioread32_copy() instead of open-coding

 drivers/firmware/broadcom/bcm47xx_nvram.c | 11 +++--------
 drivers/soc/qcom/smd.c                    | 13 ++++---------
 include/linux/io.h                        |  1 +
 lib/iomap_copy.c                          | 23 +++++++++++++++++++++++
 4 files changed, 31 insertions(+), 17 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
