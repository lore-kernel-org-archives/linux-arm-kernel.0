From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 18:41:22 -0400
Subject: [PATCH v2 0/5] ARM: keystone: Enable SPI and I2C support
Message-ID: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is small set of patches which enables I2C and SPI bus support
for Keystone SOCs. The relevant driver updates are already merged
in the last merge cycle.

v1-->v2
Only one patch is changed in the v2 from v1. Based on discussion [1],
dropped the SPI Kconfig patch which was disabling the EDMA. Since the
driver is smart enough to handle that runtime based on dma-engine DT
information, EDMA can be included in the build for Keystone SOCs.

Series is tested on Keystone 2 EVM.

Santosh Shilimkar (5):
  ARM: dts: keystone: Add i2c device nodes
  ARM: dts: keystone: Add the SPI nodes
  dma: Allow TI_EDMA selectable for ARCH_KEYSTONE
  ARM: keystone: Select TI_EDMA to be able to enable SPI driver
  ARM: keystone: Enable I2C and SPI bus support

 arch/arm/boot/dts/keystone.dts      |   57 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/keystone_defconfig |    2 ++
 arch/arm/mach-keystone/Kconfig      |    2 ++
 drivers/dma/Kconfig                 |    2 +-
 4 files changed, 62 insertions(+), 1 deletion(-)

Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg276324.html
-- 
1.7.9.5
