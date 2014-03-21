From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri, 21 Mar 2014 23:09:27 +0800
Subject: [PATCH v2 0/3] add hisilicon hip04 ethernet driver
Message-ID: <1395414570-25515-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2:
Got many suggestions from Russell, Arnd, Florian, Mark and Sergei
Remove memcpy, use dma_map/unmap_single, use dma_alloc_coherent rather than dma_pool, etc.
Refer property in ethernet.txt, change ppe description, etc.

Zhangfei Gao (3):
  Documentation: add Device tree bindings for Hisilicon hip04 ethernet
  net: hisilicon: new hip04 MDIO driver
  net: hisilicon: new hip04 ethernet driver

 .../bindings/net/hisilicon-hip04-net.txt           |  107 +++
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/hisilicon/Kconfig             |   31 +
 drivers/net/ethernet/hisilicon/Makefile            |    5 +
 drivers/net/ethernet/hisilicon/hip04_eth.c         |  730 ++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hip04_mdio.c        |  190 +++++
 7 files changed, 1065 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
 create mode 100644 drivers/net/ethernet/hisilicon/Kconfig
 create mode 100644 drivers/net/ethernet/hisilicon/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hip04_eth.c
 create mode 100644 drivers/net/ethernet/hisilicon/hip04_mdio.c

-- 
1.7.9.5
