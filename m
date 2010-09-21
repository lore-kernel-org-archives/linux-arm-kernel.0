From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 21 Sep 2010 19:37:11 +0530
Subject: [PATCH v3 0/5] Convert I2C driver to use omap_device/runtime PM
Message-ID: <1285078036-12789-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes I2C device registration use hwmod and omap_device api's
and converts the I2C driver to use runtime PM api's.

Patches apply on the pm-core branch from Kevin's tree.

v3 has minor review comment fixes over v2
The series is boot tested on a 2430sdp platform along with being tested
on 3430sdp and 4430sdp.

4430sdp tests are done using the below series 
http://www.spinics.net/lists/linux-omap/msg36023.html

Paul Walmsley (2):
  OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
  OMAP: I2C: split device registration and convert OMAP2+ to
    omap_device

Rajendra Nayak (3):
  OMAP3: hwmod: add I2C hwmods for OMAP3430
  OMAP4: hwmod: add I2C hwmods for OMAP4430
  OMAP: I2C: Convert i2c driver to use PM runtime api's

 arch/arm/mach-omap2/cm-regbits-24xx.h      |    4 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  140 ++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  154 ++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  232 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  237 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    3 +
 arch/arm/plat-omap/i2c.c                   |  124 ++++++---------
 arch/arm/plat-omap/include/plat/i2c.h      |   16 ++
 arch/arm/plat-omap/include/plat/l4_3xxx.h  |   24 +++
 drivers/i2c/busses/i2c-omap.c              |   67 +++------
 include/linux/i2c-omap.h                   |    5 +
 11 files changed, 881 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/l4_3xxx.h
