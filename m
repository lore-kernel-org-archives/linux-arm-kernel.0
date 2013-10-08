From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Oct 2013 17:29:00 -0400
Subject: [GIT PULL] Keystone SOC updates for v3.13
Message-ID: <1381267740-31874-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Please pull below Keystone SOC updates for v3.13. As discussed on irc, the
pull request is build on top of v3.13-rc4 because of dependent commit
c2b9e974{dma/Kconfig: Make TI_EDMA select TI_PRIV_EDMA}. The pull request
carries Kconfig update patch {dma: Allow TI_EDMA selectable for ARCH_KEYSTONE}
with Vinod Koul's ack as per alignment on the mailing list[1]. The clock
driver support is already applied by Mike to his 3.13 clk-next [2]

The following changes since commit ef887009524c3631d804a2587ec204c4ff61a5b8:

  ARM: keystone: Enable I2C and SPI bus support (2013-10-08 15:37:41 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc-for-arm-soc

for you to fetch changes up to ef887009524c3631d804a2587ec204c4ff61a5b8:

  ARM: keystone: Enable I2C and SPI bus support (2013-10-08 15:37:41 -0400)

----------------------------------------------------------------
SOC updates for Keystone II devices:

- Clock tree support
- Clock management support using PM core
- Keystone config update for EMDA with ack from Vinod
- Enable SPI and I2C drivers

----------------------------------------------------------------

Santosh Shilimkar (9):
  ARM: dts: keystone: Add clock tree data to devicetree
  ARM: dts: keystone: Add clock phandle to UART nodes
  ARM: keystone: Enable clock drivers
  ARM: keystone: add PM bus support for clock management
  ARM: dts: keystone: Add i2c device nodes
  ARM: dts: keystone: Add the SPI nodes
  dma: Allow TI_EDMA selectable for ARCH_KEYSTONE
  ARM: keystone: Select TI_EDMA to be able to enable SPI driver
  ARM: keystone: Enable I2C and SPI bus support

 arch/arm/boot/dts/keystone-clocks.dtsi |  821 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dts         |   63 ++-
 arch/arm/configs/keystone_defconfig    |    2 +
 arch/arm/mach-keystone/Kconfig         |    2 +
 drivers/bus/Makefile                   |    2 +
 drivers/bus/keystone_pm_bus.c          |   70 +++
 drivers/dma/Kconfig                    |    2 +-
 7 files changed, 959 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/keystone-clocks.dtsi
 create mode 100644 drivers/bus/keystone_pm_bus.c

Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg277174.html
[2] http://www.spinics.net/lists/arm-kernel/msg277924.html
-- 
1.7.9.5
