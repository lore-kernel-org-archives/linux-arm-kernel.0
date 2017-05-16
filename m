From: s-anna@ti.com (Suman Anna)
Date: Tue, 16 May 2017 17:13:44 -0500
Subject: [PATCH 0/3] Davinci DSP remoteproc device improvements
Message-ID: <20170516221347.37990-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

The following series makes some minor improvements to the legacy-mode
Davinci remoteproc device creation logic in preparation for adding the
DT support to the Davinci remoteproc driver. The patches are baselined
on 4.12-rc1. The changes include conditionally creating the DSP device
based on memory supplied to the remoteproc device, and adds resource
names and additional resources for publishing the DSP internal memory
regions to the davinci remoteproc driver.

Patches tested on OMAP-L138 LCDK board by booting it in legacy-mode.

regards
Suman

Suman Anna (3):
  ARM: davinci: da8xx: Create DSP device only when assigned memory
  ARM: davinci: da8xx: Add names to DSP IOMEM resources
  ARM: davinci: da8xx: Add DSP internal RAM memories as IOMEM resources

 arch/arm/mach-davinci/devices-da8xx.c      | 30 ++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |  5 +++++
 2 files changed, 35 insertions(+)

-- 
2.12.0
