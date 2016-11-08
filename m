From: yong.mao@mediatek.com (Yong Mao)
Date: Tue, 8 Nov 2016 14:08:57 +0800
Subject: [PATCH 0/4] Support sdio feature
Message-ID: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix CMD6 timeout issue
Add irqlock to protect accessing the shared register
Modify the implementation of msdc_card_busy
Add msdc_recheck_sdio_irq mechanism
Support sdr104_clk_delay in sdio
Add description of mmc3 for supporting sdio feature

yong mao (4):
  mmc: mediatek: Fix CMD6 timeout issue
  sdio: mediatek: Support sdio feature
  sdio: mediatek: support sdr104_clk_delay in sdio
  dts: arm64: enable mmc3 for supporting sdio feature

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  82 +++++++++
 drivers/mmc/host/mtk-sd.c                   | 254 +++++++++++++++++++++-------
 2 files changed, 271 insertions(+), 65 deletions(-)

-- 
1.8.1.1.dirty
