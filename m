From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:18 +0800
Subject: [PATCH 01/22] Fixes and clean-ups for Device Tree on Snowball
Message-ID: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set contains some fixes and clean-ups that will ensure
smooth booting on Snowball. Without them some devices will either
fail on probe, or fail to probe at all. Some patches contained
here work towards suppressing useless warning boot messages which
originate from the non-existent User Interface Board (UIB). Others
aim to fix some previous merge conflict errors previously applied
to the Mainline kernel.

 arch/arm/boot/dts/db8500.dtsi          |  204 +++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/snowball.dts         |   32 +++--
 arch/arm/configs/u8500_defconfig       |    1 +
 arch/arm/mach-ux500/board-mop500-uib.c |    4 +-
 arch/arm/mach-ux500/board-mop500.c     |   32 ++++-
 arch/arm/mach-ux500/board-mop500.h     |    4 +
 arch/arm/mach-ux500/cpu-db8500.c       |   25 +++-
 drivers/mfd/Kconfig                    |   10 --
 drivers/mfd/ab8500-gpadc.c             |    3 +-
 drivers/mfd/db8500-prcmu.c             |    6 +
 drivers/net/ethernet/smsc/smsc911x.c   |    7 +-
 drivers/pinctrl/pinctrl-nomadik.c      |   20 +++-
 drivers/regulator/ab8500.c             |   22 ++--
 drivers/regulator/db8500-prcmu.c       |   40 +++----
 drivers/rtc/rtc-ab8500.c               |    2 +-
 15 files changed, 344 insertions(+), 68 deletions(-)
