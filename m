From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 28 Jun 2012 13:41:28 -0500
Subject: [PATCH 0/2] ARM: OMAP2+: GPMC: Show correct frequency for OneNAND
 devices using async mode
Message-ID: <1340908890-28612-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards that have OneNAND devices but only support the async read and write modes
show that the OneNAND operating frequency is 0 MHz on boot. For example, the
OMAP3430 SDP shows the following:

omap2-onenand: initializing on CS2, phys base 0x20000000, virtual base c88c0000, freq 0 MHz

This series corrects this and cleans up the code that is determining the OneNAND
frequency. This series is based upon Afzal's prep-gpmc branch [1] and has been
tested on an OMAP3430 SDP.

[1] http://gitorious.org/x0148406-public/linux-kernel/trees/gpmc-prep

Jon Hunter (2):
  ARM: OMAP2+: GPMC: Remove unused OneNAND get_freq() platform function
  ARM: OMAP2+: GPMC: Show correct frequency for OneNAND devices using
    async mode

 arch/arm/mach-omap2/gpmc-onenand.c        |   53 +++++------------------------
 arch/arm/plat-omap/include/plat/onenand.h |    8 -----
 2 files changed, 9 insertions(+), 52 deletions(-)

-- 
1.7.9.5
