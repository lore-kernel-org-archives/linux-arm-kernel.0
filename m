From: andrew-ct.chen@mediatek.com (Andrew-CT Chen)
Date: Thu, 19 Nov 2015 18:46:51 +0800
Subject: [PATCH v2 0/3] Mediatek EFUSE Support
Message-ID: <1447930014-19579-1-git-send-email-andrew-ct.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EFUSE support driver which is used by other drivers
like thermal sensor and HDMI impedance.

There are some efuses these fuses store things like calibration data,
speed bins.. etc. Drivers like thermal sensor, HDMI impedance would
read out this data for configuring the driver.

Change in v2:
1. Rebase to 4.4-rc1
2. Modify the driver Makefile for more consistent with other drivers
3. Modify the compatible string to "mediatek,mt8173-efuse" and "mediatek,efuse"

Andrew-CT Chen (3):
  dt-bindings: add document of mediatek efuse driver
  nvmem: mediatek: Add Mediatek EFUSE driver
  dts: arm64: Add EFUSE device node

 .../devicetree/bindings/nvmem/mtk-efuse.txt        | 36 +++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  5 ++
 drivers/nvmem/Kconfig                              | 11 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/mtk-efuse.c                          | 89 ++++++++++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
 create mode 100644 drivers/nvmem/mtk-efuse.c

--
1.9.1
