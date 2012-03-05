From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 Mar 2012 22:41:13 -0500
Subject: [GIT PULL v3] ARM: kirkwood: fdt: convert kirkwood init funcs to fdt
Message-ID: <20120305034113.GB5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 759a45185ac0e4dfaf8bbfcb390ec73aca4b7a34:

  ARM: kirkwood: convert uart0 to devicetree. (2012-02-27 16:21:44 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt

Arnd,

Sorry for the redo, here's what changed:
	orion-spi: put #ifdef CONFIG_OF around of_device_id
	rtc-mv: put #ifdef CONFIG_OF around of_device_id
	rtc-mv: more accurate compatible strings
	orion-wdt: put #ifdef CONFIG_OF around of_device_id
	orion-wdt: more accurate compatible strings

Jason Cooper (5):
      ARM: kirkwood: covert orion-spi to fdt.
      ARM: kirkwood: move var setting to correct location.
      ARM: kirkwood: fdt: absorb kirkwood_init()
      ARM: kirkwood: convert rtc-mv to fdt.
      ARM: kirkwood: convert orion-wdt to fdt.

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   34 +++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi          |   12 +++++
 arch/arm/mach-kirkwood/board-dt.c        |   67 +++++++++++------------------
 arch/arm/mach-kirkwood/common.c          |   21 +++++++--
 arch/arm/mach-kirkwood/common.h          |    6 +++
 arch/arm/plat-orion/common.c             |    7 +++-
 drivers/rtc/rtc-mv.c                     |   10 ++++
 drivers/spi/spi-orion.c                  |   39 +++++++++++++++--
 drivers/watchdog/orion_wdt.c             |   49 ++++++++++++++++-----
 9 files changed, 182 insertions(+), 63 deletions(-)
