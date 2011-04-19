From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 19 Apr 2011 15:04:13 +0300
Subject: [PATCH 0/2] OMAP: convert boards that use SMSC911x to use
	gpmc-smsc911x
Message-ID: <cover.1302992702.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several OMAP boards that use SMSC911x Ethernet controller. Convert them all to use gpmc-smsc911x for device registration.

Mike Rapoport (2):
  OMAP: gpmc-smsc911x: always set irq flags to IORESOURCE_IRQ_LOWLEVEL
  OMAP: convert boards that use SMSC911x to use gpmc-smsc911x

 arch/arm/mach-omap2/board-cm-t35.c          |   84 +++------------------
 arch/arm/mach-omap2/board-igep0020.c        |   53 ++-----------
 arch/arm/mach-omap2/board-ldp.c             |   65 ++--------------
 arch/arm/mach-omap2/board-omap3evm.c        |   71 +++---------------
 arch/arm/mach-omap2/board-omap3logic.c      |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c    |   48 ++----------
 arch/arm/mach-omap2/board-overo.c           |  108 ++++-----------------------
 arch/arm/mach-omap2/board-zoom-debugboard.c |   56 ++------------
 arch/arm/mach-omap2/gpmc-smsc911x.c         |    7 +-
 9 files changed, 70 insertions(+), 423 deletions(-)

-- 
1.7.3.1
