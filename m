From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jan 2011 15:42:21 -0800
Subject: [GIT PULL for 38-rc3] msm: sdcc driver fixes
Message-ID: <8yatygxj2ci.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches fix some problems with the MMC/SD driver for MSM
chips.  The first fixes a compilation error.  The driver was using
internal DMA apis, this fix changes it to use the proper APIs.  The
second patch fixes a clock enable/disable mismatch.

Thanks,
David Brown

The following changes since commit c56eb8fb6dccb83d9fe62fd4dc00c834de9bc470:

  Linux 2.6.38-rc1 (2011-01-18 15:14:02 -0800)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git for-38-rc3

Daniel Walker (2):
      mmc: msm: fix dma usage not to use internal APIs
      drivers: mmc: msm: remove clock disable in probe

 drivers/mmc/host/msm_sdcc.c |   52 ++++++++++++++++++------------------------
 1 files changed, 22 insertions(+), 30 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
