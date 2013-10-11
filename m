From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Oct 2013 20:16:36 -0400
Subject: [GIT PULL v2] Keystone SOC updates for v3.13
Message-ID: <1381450596-27199-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

Please pull below Keystone SOC updates for v3.13. I moved the PM bus
code under machine directory and renamed as 'domain' as you suggested.
As discussed on irc(Olof), the pull request is build on top of v3.13-rc4
because of dependent commit c2b9e974{dma/Kconfig: Make TI_EDMA select
TI_PRIV_EDMA}. The pull request carries Kconfig update patch {dma: Allow
TI_EDMA selectable for ARCH_KEYSTONE} with Vinod Koul's ack as per
alignment on the mailing list[1]. The clock driver support is already
applied by Mike to his 3.13 clk-next [2]

The following changes since commit 4385a83d19be799c21af43fbb1ac90364d7a2384:

  ARM: keystone: Enable I2C and SPI bus support (2013-10-10 19:52:18 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc-for-arm-soc

for you to fetch changes up to 4385a83d19be799c21af43fbb1ac90364d7a2384:

  ARM: keystone: Enable I2C and SPI bus support (2013-10-10 19:52:18 -0400)

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
  ARM: keystone: add PM domain support for clock management
  ARM: dts: keystone: Add i2c device nodes
  ARM: dts: keystone: Add the SPI nodes
  dma: Allow TI_EDMA selectable for ARCH_KEYSTONE
  ARM: keystone: Select TI_EDMA to be able to enable SPI driver
  ARM: keystone: Enable I2C and SPI bus support

 arch/arm/boot/dts/keystone-clocks.dtsi |  821 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dts         |   63 ++-
 arch/arm/configs/keystone_defconfig    |    2 +
 arch/arm/mach-keystone/Kconfig         |    2 +
 arch/arm/mach-keystone/Makefile        |    3 +
 arch/arm/mach-keystone/pm_domain.c     |   70 +++
 drivers/dma/Kconfig                    |    2 +-
 7 files changed, 960 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/keystone-clocks.dtsi
 create mode 100644 arch/arm/mach-keystone/pm_domain.c

Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg277174.html
[2] http://www.spinics.net/lists/arm-kernel/msg277924.html

-- 
1.7.9.5
