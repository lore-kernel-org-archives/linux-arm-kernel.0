From: kishore.kadiyala@ti.com (kishore kadiyala)
Date: Sat, 18 Sep 2010 22:03:49 +0530 (IST)
Subject: [PATCH v2 0/4] OMAP4 hsmmc :card detect and Register offset handling
Message-ID: <33880.10.24.255.17.1284827629.squirrel@dbdmail.itg.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series is basically for OMAP4 and is based on mainline 2.6.36-rc4.
The series is tested on OMAP3430SDP and OMAP4430SDP and has dependency on
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg34718.html

V1:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg34040.html

Kishore Kadiyala (3):
  omap4 hsmmc : Adding card detect support for MMC1
  omap4 hsmmc: Register offset handling
  omap4 hsmmc: Update ocr mask for MMC2 for regulator to use

Benoit Cousson (1);
  omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not set


 arch/arm/mach-omap2/board-4430sdp.c   |   16 ++++++-
 arch/arm/mach-omap2/devices.c         |    8 +--
 arch/arm/mach-omap2/hsmmc.c           |    4 ++
 arch/arm/plat-omap/include/plat/mmc.h |    3 +
 drivers/mfd/twl6030-irq.c             |   76 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |   18 ++++++-
 include/linux/i2c/twl.h               |   31 +++++++++++++
 7 files changed, 146 insertions(+), 10 deletions(-)
