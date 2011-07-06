From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 6 Jul 2011 11:31:19 +0530
Subject: [PATCH 0/5] davinci: da850: add SATA support
Message-ID: <cover.1309927427.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add support for platform AHCI driver on
DA850/OMAP-L138/AM18x. Towards this purpose, it also
adds support for forced module transtitions on PSC.

Sekhar Nori (5):
  davinci: psc.h: clean up indentation done using spaces
  davinci: pass clock flags to davinci_psc_config()
  davinci: enable forced transitions on PSC
  davinci: da850: add support for SATA interface
  davinci: da850 evm: register SATA device

 arch/arm/mach-davinci/board-da850-evm.c    |    7 ++
 arch/arm/mach-davinci/clock.c              |    8 +-
 arch/arm/mach-davinci/clock.h              |    1 +
 arch/arm/mach-davinci/da850.c              |    9 ++
 arch/arm/mach-davinci/devices-da8xx.c      |  126 +++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 arch/arm/mach-davinci/include/mach/psc.h   |  151 ++++++++++++++--------------
 arch/arm/mach-davinci/psc.c                |   14 +++-
 8 files changed, 237 insertions(+), 81 deletions(-)

-- 
1.7.3.2
