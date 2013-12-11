From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 11 Dec 2013 22:02:18 +0800
Subject: [PATCH v4 0/3] mmc: dw_mmc: add dw_mmc-k3
Message-ID: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:
Follow Arnd's suggestion abstracting specific tuning to clock,
also because new version ip use different method and not use same tuning registers.

0001 acked by Jaehoon

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

Zhangfei Gao (3):
  mmc: dw_mmc: use slot-gpio to handle cd pin
  mmc: dw_mmc: add dw_mmc-k3 for k3 platform
  clk: hisilicon: add hi3620_mmc_clks

 .../bindings/arm/hisilicon/hisilicon.txt           |   14 ++
 .../devicetree/bindings/clock/hi3620-clock.txt     |    1 +
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   51 ++++
 drivers/clk/hisilicon/clk-hi3620.c                 |  266 ++++++++++++++++++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  136 ++++++++++
 drivers/mmc/host/dw_mmc.c                          |   48 +++-
 include/dt-bindings/clock/hi3620-clock.h           |    5 +
 9 files changed, 519 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5
