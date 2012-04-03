From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Tue, 3 Apr 2012 18:39:35 +0530
Subject: [PATCH-V3 0/3] ARM: OMAP3+: am33xx: Add CM,
 clock and clockdomain support
Message-ID: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds CM low-level api's, clockdomain data,
respective clockdomain operations and complete Clock Tree for
AM33XX family of devices.

The earlier versions of patches submitted were,

 - Patch-RFC was complete set of patches adding separate
   implementation for all PRM, CM, Clockdomain, clock tree and HWMOD.
 - Patch-V2 was basically reusing existing OMAP4 cminst and
   clockdomain api's for AM33XX device (without clock tree).

But as aligned and discussed on previous patch submission on
AM33XX PRM, we have decided to implement/handle whole AM33xx
separately.

Please refer to the AM335x TRM available at -
http://www.ti.com/product/am3359

I would like to bring same question again (but from CM context),

Do we really want to implement CM and clockdomain api's separately?
  In case of AM33XX PRM implementation, the reason why we had to
  do it separately was, due to inconsistency of register offset and
  bit-offsets. But, it is not the case in CM implementation, we have
  some consistency there and existing OMAP4 code can be reused
  for AM33XX.
  I personally feel, we should consider Patch-V2 version here.
  IMO, the only change required there is to rename files,
    cminst44xx.c => cminst_33xx_44xx.c
    clockdomain44xx.c => clockdomain_33xx_44xx.c


Vaibhav Hiremath (3):
  ARM: OMAP3+: cm33xx: Introduce AM33xx CM API's and register level
    details
  ARM: OMAP3+: clockdomain33xx: Add clockdomain data and respective
    operations
  ARM: OMAP3+: clock33xx: Add AM33XX clock tree data

 arch/arm/mach-omap2/Makefile                  |    6 +
 arch/arm/mach-omap2/clock33xx.h               |   36 +
 arch/arm/mach-omap2/clock33xx_data.c          | 2209 +++++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h             |    2 +
 arch/arm/mach-omap2/clockdomain33xx.c         |   74 +
 arch/arm/mach-omap2/clockdomains33xx_data.c   |  214 +++
 arch/arm/mach-omap2/cm-regbits-33xx.h         |  687 ++++++++
 arch/arm/mach-omap2/cm33xx.c                  |  313 ++++
 arch/arm/mach-omap2/cm33xx.h                  |  420 +++++
 arch/arm/mach-omap2/io.c                      |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c              |   58 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 12 files changed, 4006 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock33xx.h
 create mode 100644 arch/arm/mach-omap2/clock33xx_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/clockdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/cm33xx.c
 create mode 100644 arch/arm/mach-omap2/cm33xx.h
