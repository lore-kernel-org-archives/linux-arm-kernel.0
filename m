From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 22:54:06 +0200
Subject: [PATCH 0/5] ARM: dts: rockchip: small cleanups
Message-ID: <1459457651-4727-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some missing unitnames on nodes having a reg property
and drop unitnames on gpio-keys.

This explicitly leaves out the memory nodes, as it seems
memory without unitname will keep being allowed, also
to keep compatibility with bootloaders who may insert the
actual amount of memory into those nodes. [0]


[0] http://www.spinics.net/lists/arm-kernel/msg494038.html

Heiko Stuebner (5):
  ARM: dts: rockchip: fix rk3288 power-domain unit names
  ARM: dts: rockchip: fix missing usbphy unit-names
  ARM: dts: rockchip: clean up gpio-keys nodes
  ARM: dts: rockchip: drop unneeded properties from mipi node
  ARM: dts: rockchip: add missing unitname to cpu_leakage efuse

 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 11 +++++------
 arch/arm/boot/dts/rk3066a-rayeager.dts |  7 +++----
 arch/arm/boot/dts/rk3066a.dtsi         |  6 +++---
 arch/arm/boot/dts/rk3188-radxarock.dts |  7 +++----
 arch/arm/boot/dts/rk3188.dtsi          |  6 +++---
 arch/arm/boot/dts/rk3288-evb.dtsi      |  7 +++----
 arch/arm/boot/dts/rk3288-firefly.dtsi  |  7 +++----
 arch/arm/boot/dts/rk3288-popmetal.dts  |  8 +++-----
 arch/arm/boot/dts/rk3288-r89.dts       |  7 +++----
 arch/arm/boot/dts/rk3288.dtsi          | 18 +++++++-----------
 drivers/spi/spi.c                      |  4 ++--
 11 files changed, 38 insertions(+), 50 deletions(-)

-- 
2.6.4
