From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 14 Aug 2013 14:52:07 +0200
Subject: [PATCH 0/2] DMA: AMBA PL08x DMA driver fixes due to
 ARCH_DMA_ADDR_T_64BIT
Message-ID: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob's recent pull request (Highbank fixes for 3.12) promoted the
dma_addr_t to 64bit:
commit ac072f427a4266b28a948c67a97a8c46f49b662d
Author: Rob Herring <rob.herring@calxeda.com>
Date:   Tue Aug 13 15:55:07 2013 -0500

    ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
    
Unfortunately this breaks the AMBA PL08x driver.
Fixes are pretty easy: replacing modulo with AND and fix printk
format types.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>

Andre Przywara (2):
  DMA: fix AMBA PL08x driver issue with 64bit DMA address type
  DMA: fix printk warning in AMBA PL08x DMA driver

 drivers/dma/amba-pl08x.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
1.7.12.1
