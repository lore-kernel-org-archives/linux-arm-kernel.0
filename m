From: yong.mao@mediatek.com (Yong Mao)
Date: Thu, 12 Jan 2017 18:04:48 +0800
Subject: [PATCH 0/2] Use data tune for CMD line tune
Message-ID: <1484215490-7494-1-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CMD response CRC error may cause cannot boot up
Change to use data tune for CMD line
Separate cmd internal delay for HS200/HS400 mode

yong mao (2):
  mmc: mediatek: Use data tune for CMD line tune
  mmc: dt-bindings: update Mediatek MMC bindings

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   6 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |   3 +
 drivers/mmc/host/mtk-sd.c                        | 169 ++++++++++++++++++++---
 3 files changed, 155 insertions(+), 23 deletions(-)

-- 
1.8.1.1
