From: khilman@ti.com (Kevin Hilman)
Date: Tue,  8 May 2012 15:02:53 -0700
Subject: [PATCH 0/3] ARM: OMAP2+: Kconfig: minor cleanup for SOC names
Message-ID: <1336514576-4870-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CONFIG_SOC_* names for do not need an OMAP in the name since
these are not called OMAP in most places.  Drop the OMAP in the Kconfig
names to improve readability.

Also fixes an obvious bug found in the TI81xx code which suggests that
nobody is using the highest 32 interrupts on these SoCs, or nobody
is using mainline for TI81xx.

Kevin Hilman (3):
  ARM: OMAP2+: INTC: fix Kconfig option for TI81XX
  ARM: OMAP2+: Kconfig: convert SOC_OMAPTI81XX to SOC_TI81XX
  ARM: OMAP2+: Kconfig: convert SOC_OMAPAM33XX to SOC_AM33XX

 arch/arm/mach-omap2/Kconfig  |    8 ++++----
 arch/arm/mach-omap2/common.h |    4 ++--
 arch/arm/mach-omap2/io.c     |    8 ++++----
 arch/arm/mach-omap2/irq.c    |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.7.9.2
