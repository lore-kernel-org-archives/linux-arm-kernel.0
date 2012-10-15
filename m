From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 15 Oct 2012 21:16:30 +0200
Subject: [PATCH 0/5] am335x fixes for 3.7-rc2
Message-ID: <cover.1350327320.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains patches required to let the kernel run on a TI
am335x, like the popular BeagleBone. None of these patches are from
me, yet all of them are essential fixes. For net-next I have prepared
a cpsw driver extension that enables time stamping and a PTP clock,
but in order to be useful, the kernel must boot and the MAC driver
must be working.

The first patch was supposed to have made -rc1, but it seems to have
been forgotten. The other four patches are for the cpsw MAC driver,
which has not worked since the migration to device tree. Actually, I
am not sure if the cpsw ever did work, but in any case these patches
let the driver work (again), rather than being a lifeless derelict.

Thanks,
Richard


Mugunthan V N (2):
  ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for davinci_mdio
  arm/dts: am33xx: Add cpsw and mdio module nodes for AM33XX

Vaibhav Hiremath (2):
  net: davinci_mdio: Fix type mistake in calling runtime-pm api
  net: cpsw: Add parent<->child relation support between cpsw and mdio

hvaibhav at ti.com (1):
  ARM: OMAP2+: gpmc: Fix kernel BUG for DT boot mode

 arch/arm/boot/dts/am335x-bone.dts          |    8 ++++
 arch/arm/boot/dts/am335x-evm.dts           |    8 ++++
 arch/arm/boot/dts/am33xx.dtsi              |   50 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.c                 |    4 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   34 ++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw.c             |   16 ++++++++-
 drivers/net/ethernet/ti/davinci_mdio.c     |    2 +-
 7 files changed, 117 insertions(+), 5 deletions(-)

-- 
1.7.2.5
