From: addy.ke@rock-chips.com (Addy Ke)
Date: Mon, 26 Jan 2015 19:19:33 +0800
Subject: [PATCH 0/2] fix bug that cause tuning failure
Message-ID: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy Ke (2):
  mmc: core: use card pointer as the first parameter of execute_tuning()
  mmc: dw_mmc: wait until card ready if tuning fails

 drivers/mmc/core/core.c           |  2 +-
 drivers/mmc/core/mmc_ops.h        |  1 -
 drivers/mmc/host/dw_mmc.c         | 51 +++++++++++++++++++++++++++++++++------
 drivers/mmc/host/rtsx_pci_sdmmc.c |  3 ++-
 drivers/mmc/host/rtsx_usb_sdmmc.c |  3 ++-
 include/linux/mmc/card.h          |  2 ++
 include/linux/mmc/host.h          |  2 +-
 7 files changed, 52 insertions(+), 12 deletions(-)

-- 
1.8.3.2
