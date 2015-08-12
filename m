From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 12 Aug 2015 16:24:01 +0800
Subject: [PATCH 0/4] msdc: Add tuning support of Mediatek MMC host
Message-ID: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add tuning support for EMMC/SD transfer.
The tuning thread was start when CMD/DAT crc error deteted,
for some SD card, tune DAT crc error may occur data timeout,
in this case, try to reset card to recover.
With tuning support, can support SDR104/HS200/HS400 modes

Chaotian Jing (4):
  mmc: mediatek: Add online-tuning support of EMMC/SD
  mmc: mediatek: Add HS400 support
  arm64: dts: mediatek: Support SD/EMMC SDR104/HS200/HS400
  mmc: dt-bindings:  Add 400Mhz clock source

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  10 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  10 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   5 +-
 drivers/mmc/host/mtk-sd.c                        | 256 ++++++++++++++++++++---
 4 files changed, 248 insertions(+), 33 deletions(-)
