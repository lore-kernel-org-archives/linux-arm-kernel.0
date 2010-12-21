From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 21 Dec 2010 14:58:35 -0800
Subject: [GIT PULL] OMAP OPP support for 2.6.38
Message-ID: <87zkryvilg.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

The main OPP driver is already in manline, here is the OMAP-specific
implementation of OPPs.   Targeted for 2.6.38 and based on your
omap-for-linus branch due to dependencies.

Kevin


The following changes since commit 4584acc3ee236424b5d0b52f143d980cae3c2be5:

  Merge branches 'devel-iommu-mailbox' and 'devel-l2x0' into omap-for-linus (2010-12-20 19:13:40 -0800)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-opp

Kevin Hilman (1):
      OMAP3: remove OPP interfaces from OMAP PM layer

Nishanth Menon (2):
      omap: opp: add OMAP3 OPP table data and common init
      omap4: opp: add OPP table data

 Documentation/arm/OMAP/omap_pm            |   25 +++++++
 arch/arm/mach-omap2/Kconfig               |    4 +
 arch/arm/mach-omap2/Makefile              |    7 ++
 arch/arm/mach-omap2/io.c                  |    3 +-
 arch/arm/mach-omap2/omap_opp_data.h       |   72 +++++++++++++++++++
 arch/arm/mach-omap2/opp.c                 |   93 +++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c        |  107 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp4xxx_data.c        |   57 +++++++++++++++
 arch/arm/mach-omap2/pm.h                  |   14 ++++
 arch/arm/plat-omap/include/plat/omap-pm.h |   31 +++------
 arch/arm/plat-omap/omap-pm-noop.c         |   11 +---
 11 files changed, 391 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_opp_data.h
 create mode 100644 arch/arm/mach-omap2/opp.c
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/opp4xxx_data.c
