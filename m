From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:45 +0100
Subject: [PATCH v1 0/24] Zynq DT changes
Message-ID: <cover.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is respin of Jagan v3 series sent here
http://lists.denx.de/pipermail/u-boot/2013-December/169617.html
+ 2 patches v4
http://lists.denx.de/pipermail/u-boot/2013-December/169753.html
http://lists.denx.de/pipermail/u-boot/2013-December/169752.html

The purpose of this series was to synchronized configuration
which we are using with mainline version with adding features
which we are using.

The major change, which I have done, is adding DT support for
all zynq boards instead of board specification configurations.
I have changed serial, gem, emaclite, mmc.
i2c, spi already support bus selection.

For more information please look at patches.

All series are available here for easier testing.
http://git.denx.de/?p=u-boot/u-boot-microblaze.git;a=shortlog;h=refs/heads/zynq

Thanks,
Michal

Changes in v1:
- Remove doc compare to origin Jagan version
- Update to the latest status

Jagannadha Sutradharudu Teki (19):
  gpio: zynq: Add dummy gpio routines
  zynq: Enable CONFIG_FIT_VERBOSE
  zynq: Enable Boot FreeBSD/vxWorks
  zynq: Cleanup on miscellaneous configs
  zynq: Cleanup on memory configs
  zynq: Minor config cleanup
  zynq: Enable cache options
  zynq: serial: Simplify serial driver initialization
  zynq: Add GEM0, GEM1 configs support
  zynq-common: Define exact TEXT_BASE
  zynq: Add Catalyst 24WC08 EEPROM config support
  zynq-common: Define default environment
  zynq-common: Change Env. Sector size to 128Kb
  zynq-common: Define flash env. partition
  zynq-common: Define CONFIG_ENV_OVERWRITE
  zynq: Add support to find bootmode
  dts: zynq: Add fdt support
  zynq-common: Enable verified boot(RSA)
  doc: zynq: Add information on zynq u-boot

Michal Simek (5):
  net: emaclite: Fix OF initialization
  net: gem: Add OF initialization support
  mmc: zynq: Add OF initialization support
  zynq: Add OF ram initialization support
  serial: zynq: Add OF initialization support

 arch/arm/cpu/armv7/zynq/slcr.c             |   6 +
 arch/arm/include/asm/arch-zynq/gpio.h      |  25 ++
 arch/arm/include/asm/arch-zynq/hardware.h  |   2 +
 arch/arm/include/asm/arch-zynq/sys_proto.h |   2 +
 board/xilinx/dts/zynq-generic.dts          | 421 +++++++++++++++++++++++++++++
 board/xilinx/zynq/board.c                  |  75 +++--
 doc/README.zynq                            |  76 ++++++
 drivers/mmc/zynq_sdhci.c                   |  29 ++
 drivers/net/xilinx_emaclite.c              |  15 +-
 drivers/net/zynq_gem.c                     |  42 +++
 drivers/serial/serial_zynq.c               |  62 ++++-
 include/configs/zynq.h                     | 203 +++++++++-----
 include/netdev.h                           |   2 +
 13 files changed, 850 insertions(+), 110 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-zynq/gpio.h
 create mode 100644 board/xilinx/dts/zynq-generic.dts
 create mode 100644 doc/README.zynq

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/24042e5f/attachment.sig>
