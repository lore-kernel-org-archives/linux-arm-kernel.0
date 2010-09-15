From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 15 Sep 2010 14:56:35 -0700
Subject: [PATCH 0/4] OMAP OPP layer for 2.6.37
Message-ID: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces a layer to manage Operating Performance Points (OPPs)
for OMAP SoCs.

Special thanks to Nishanth for doing the bulk of the work on this
series and to Thara for doing significant review, testing and updates.

Kevin Hilman (1):
  OMAP3: remove OPP interfaces from OMAP PM layer

Nishanth Menon (2):
  OMAP: introduce OPP layer for device-specific OPPs
  OMAP3: OPP: add OPP table data and initialization

Paul Walmsley (1):
  OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code

 Documentation/arm/OMAP/omap_pm                |   83 +++++
 arch/arm/mach-omap2/Makefile                  |    2 +
 arch/arm/mach-omap2/io.c                      |    3 +-
 arch/arm/mach-omap2/opp3xxx_data.c            |  126 +++++++
 arch/arm/mach-omap2/pm.c                      |    6 +
 arch/arm/mach-omap2/pm.h                      |    1 +
 arch/arm/plat-omap/Makefile                   |    6 +
 arch/arm/plat-omap/include/plat/omap-pm.h     |   31 +--
 arch/arm/plat-omap/include/plat/opp.h         |  145 ++++++++
 arch/arm/plat-omap/include/plat/opp_twl_tps.h |   21 ++
 arch/arm/plat-omap/omap-pm-noop.c             |   11 +-
 arch/arm/plat-omap/opp.c                      |  461 +++++++++++++++++++++++++
 arch/arm/plat-omap/opp_twl_tps.c              |   41 +++
 13 files changed, 904 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.c
 create mode 100644 arch/arm/plat-omap/include/plat/opp.h
 create mode 100644 arch/arm/plat-omap/include/plat/opp_twl_tps.h
 create mode 100644 arch/arm/plat-omap/opp.c
 create mode 100644 arch/arm/plat-omap/opp_twl_tps.c

-- 
1.7.2.1
