From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 May 2014 12:57:16 -0700
Subject: [PATCH v2 0/4] ks8851 DT/regulator/gpio updates
Message-ID: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches properly documents the micrel ks8851 spi ethernet
controller, converts to devm_regulator_get_optional() to make error
paths slightly simpler, and finally adds supports for another
optional regulator and a reset gpio. This allows me to use the ks8851
on my MSM8960 CDP board.

Changes since v1:
 * Dropped vendor prefix patch as that should go through DT tree

Stephen Boyd (4):
  devicetree: bindings: Properly document micrel ks8851 SPI chips
  net: ks8851: Use devm_regulator_get_optional()
  net: ks8851: Add optional vdd_io regulator and reset gpio
  net: ks8851: Add of match table

 .../devicetree/bindings/net/micrel-ks8851.txt      | 15 ++++-
 drivers/net/ethernet/micrel/ks8851.c               | 71 +++++++++++++++++++---
 2 files changed, 74 insertions(+), 12 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
