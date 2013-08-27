From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 27 Aug 2013 10:20:09 +0800
Subject: [PATCH v4] dmaengine: add k3dma 
Message-ID: <1377570010-21870-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change since v3:
Rebase to slave-dma.git, next branch
Fix two warnning reported via smatch

change since v2:
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

Zhangfei Gao (1):
  dmaengine: Add hisilicon k3 DMA engine driver

 Documentation/devicetree/bindings/dma/k3dma.txt |   46 ++
 drivers/dma/Kconfig                             |    9 +
 drivers/dma/Makefile                            |    1 +
 drivers/dma/k3dma.c                             |  837 +++++++++++++++++++++++
 4 files changed, 893 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/k3dma.txt
 create mode 100644 drivers/dma/k3dma.c

-- 
1.7.9.5
