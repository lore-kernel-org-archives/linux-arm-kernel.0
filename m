From: andrew-ct.chen@mediatek.com (andrew-ct.chen at mediatek.com)
Date: Fri, 16 Oct 2015 16:39:08 +0800
Subject: [PATCH 0/3] Mediatek EFUSE Support
Message-ID: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EFUSE support driver which is used by other drivers
like thermal sensor and HDMI impedance.

There are some efuses these fuses store things like calibration data,
speed bins.. etc. Drivers like thermal sensor, HDMI impedance would
read out this data for configuring the driver.

Andrew-CT Chen (3):
  dt-bindings: add document of mediatek efuse driver
  nvmem: mediatek: Add Mediatek EFUSE driver
  dts: arm64: Add EFUSE device node

 .../devicetree/bindings/nvmem/mtk-efuse.txt        | 36 +++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  5 ++
 drivers/nvmem/Kconfig                              | 11 +++
 drivers/nvmem/Makefile                             |  1 +
 drivers/nvmem/mtk-efuse.c                          | 89 ++++++++++++++++++++++
 5 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
 create mode 100644 drivers/nvmem/mtk-efuse.c

--
1.9.1
