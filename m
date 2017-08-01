From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 1 Aug 2017 10:11:13 +0530
Subject: [PATCH 0/6] ARM: dts: keystone-k2g: Add support for eDMA and MMC
Message-ID: <20170801044119.16201-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT nodes and documentation for eDMA and MMC IPs on
Keystone 66AK2G SoC. Also enable the required configs in keystone_defconfig.

This series depends on Keerthy's gpio node patches on 66AK2G:
https://patchwork.kernel.org/patch/9864311/

Tested:
k2g-evm with rootfs on mmc: http://pastebin.ubuntu.com/25217978/

Lokesh Vutla (5):
  dt-bindings: ti,edma: Add 66AK2G specific information
  dt-bindings: ti,omap-hsmmc: Add 66AK2G mmc controller
  ARM: dts: keystone-k2g: add MMC0 and MMC1 nodes
  ARM: dts: keystone-k2g-evm: Enable MMC0 and MMC1
  ARM: configs: keystone: Enable MMC and regulators

Peter Ujfalusi (1):
  ARM: dts: keystone-k2g: Add eDMA nodes

 Documentation/devicetree/bindings/dma/ti-edma.txt  | 95 +++++++++++++++++++--
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      | 52 ++++++++----
 arch/arm/boot/dts/keystone-k2g-evm.dts             | 53 ++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi                | 98 ++++++++++++++++++++++
 arch/arm/configs/keystone_defconfig                |  4 +
 5 files changed, 282 insertions(+), 20 deletions(-)

-- 
2.13.0
