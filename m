From: davidb@codeaurora.org (David Brown)
Date: Tue, 23 Aug 2011 10:39:12 -0700
Subject: [PATCH 0/6] mmc: msm_sdcc Various fixes.
Message-ID: <1314121158-3319-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sahitya sent these out back in May, and I wanted to make sure they got
reviewed before pulling them in.

Sahitya Tummala (5):
  mmc: msm_sdcc: Handle error cases in probe
  mmc: msm_sdcc: Enable SDC host->clk only after setting the rate.
  msm: mmc: Remove "pio_irq" resource
  mmc: msm_sdcc: Use MCI_INT_MASK0 for PIO interrupts
  mmc: msm_sdcc: Change initialization order of busclk_timer in probe

Subhash Jadavani (1):
  mmc: msm_sdcc: Handle dma resource not present case

 arch/arm/mach-msm/devices-msm7x00.c |   24 ------------
 arch/arm/mach-msm/devices-qsd8x50.c |   24 ------------
 drivers/mmc/host/msm_sdcc.c         |   67 +++++++++++++++++++++++------------
 drivers/mmc/host/msm_sdcc.h         |    6 +++-
 4 files changed, 49 insertions(+), 72 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
