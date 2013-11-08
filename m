From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri,  8 Nov 2013 13:38:45 +0800
Subject: [PATCH v3 0/2] mmc: dw_mmc: add dw_mmc-k3
Message-ID: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
0001: 
Put set/clear_bit DW_MMC_CARD_PRESENT in dw_mci_get_cd, 
Since dw_mci_request will check DW_MMC_CARD_PRESENT before sending cmd

0002:
Follow suggestion from Chris, Kumar and Seungwon
Sync to latest mmc-next, which is 3.12-rc2
Remove enum dw_mci_k3_type etc

v2:
Follow Jaehoon's suggestion
Use slot-gpio.c handle cd pin
Move table out to dts
other suggestion

Zhangfei Gao (2):
  mmc: dw_mmc: add dw_mci_of_get_cd_gpio to handle cd pin
  mmc: dw_mmc: add dw_mmc-k3 for k3 platform

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   83 +++++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  247 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c                          |   52 +++--
 5 files changed, 380 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5
