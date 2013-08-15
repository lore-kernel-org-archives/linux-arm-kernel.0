From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 15 Aug 2013 15:02:41 +0800
Subject: [PATCH v3 0/2] dmaengine: add k3dma 
Message-ID: <1376550163-30145-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change since v2:
0001: 
Dan Carpenter find compile warnning

0002:
Vinod suggest use __ffl, remove "#ifdef CONFIG_PM_SLEEP" and 
micro namespace

change since v1:
Follow Arnd suggestion:
using dma_get_slave_channel interface
Correct dma-channels and dma-requests for phy and virt channel

Follow Vinod suggestion:
add name space
use SIMPLE_DEV_PM_OPS

Besides:
add pause/resume
Using kzalloc instead of dma pool

Zhangfei Gao (2):
  dmaengine: add interface of dma_get_slave_channel
  dmaengine: Add hisilicon k3 DMA engine driver

 Documentation/devicetree/bindings/dma/k3dma.txt |   46 ++
 drivers/dma/Kconfig                             |    9 +
 drivers/dma/Makefile                            |    1 +
 drivers/dma/dmaengine.c                         |   25 +
 drivers/dma/k3dma.c                             |  840 +++++++++++++++++++++++
 include/linux/dmaengine.h                       |    1 +
 6 files changed, 922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/k3dma.txt
 create mode 100644 drivers/dma/k3dma.c

-- 
1.7.9.5
