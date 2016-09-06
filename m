From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 17:37:11 +0100
Subject: [PATCH 0/8] More SA11x0/PXA related fixes
Message-ID: <20160906163711.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More fixes for SA11x0/PXA:

* Locomo blows up because it uses the wrong data for the handler,
  overwriting the chip's data.

* Fixes for PCMCIA problems discovered by Robert.

* Fixing SA1111 suspend/resume

Can I have acks for these please, so I can push them to Linus later
this week.  Thanks.

 arch/arm/common/locomo.c           |  5 ++---
 arch/arm/common/sa1111.c           | 32 +++++++++++++++++++-------------
 arch/arm/mach-pxa/lubbock.c        | 14 ++++++++++++++
 drivers/pcmcia/pxa2xx_base.c       |  9 +++++----
 drivers/pcmcia/pxa2xx_base.h       |  2 +-
 drivers/pcmcia/sa1111_badge4.c     | 22 ++++++++--------------
 drivers/pcmcia/sa1111_generic.c    | 22 +++++++++++++++++-----
 drivers/pcmcia/sa1111_jornada720.c | 25 ++++++++++---------------
 drivers/pcmcia/sa1111_lubbock.c    | 32 +++++++++++++-------------------
 drivers/pcmcia/sa1111_neponset.c   | 26 ++++++++++----------------
 10 files changed, 99 insertions(+), 90 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
