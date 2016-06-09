From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Thu, 9 Jun 2016 20:40:31 +0530
Subject: [PATCH 0/8] Improve Rx/Tx DMA implementation
Message-ID: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bhuvanchandra DV (5):
  tty: serial: fsl_lpuart: Fix broken 8m/s1 support
  tty: serial: fsl-lpuart: Use cyclic DMA for Rx
  tty: serial: fsl-lpuart: Use scatter/gather DMA for Tx Drop PIO to DMA
    switching and use scatter/gather DMA for Tx path to improve
    performance.
  tty: serial: fsl-lpuart: Update suspend/resume for DMA mode
  tty: serial: fsl_lpuart: Add support for RS-485

Stefan Agner (3):
  tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
  tty: serial: fsl_lpuart: support suspend/resume
  tty: serial: fsl_lpuart: fix clearing of receive flag

 drivers/clk/imx/clk-vf610.c     |  12 +-
 drivers/tty/serial/fsl_lpuart.c | 810 +++++++++++++++++++++++-----------------
 2 files changed, 482 insertions(+), 340 deletions(-)

-- 
2.8.3
