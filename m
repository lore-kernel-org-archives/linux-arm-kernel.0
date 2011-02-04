From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu,  3 Feb 2011 19:34:47 -0500
Subject: [PATCH 0/3] spi: davinci: move eventq parameter to platform data 
Message-ID: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For DMA operation, the davinci spi driver needs an eventq number.
Currently, this number is passed as a IORESOURCE_DMA.  This is not
correct, as the eventq is not a DMA channel.  Pass the eventq
via the platform data structure instead as is done with davinci
devices such as the McASP.

Two platforms (dm355 and dm365) are using the davinci spi driver 
with DMA's enabled, move the eventq parameter out of the resources
and into the platform data.

I have tested this patch with an OMAP-L138 (patch submission for this
platform is in progress).  I do not have a dm355 or dm365, so these
platforms have not been tested.

Michael Williamson (3):
  davinci: spi: move event_q parameter to platform data
  davinci: dm355: move spi0 eventq assignment from resources to
    platform data
  davinci: dm365: move spi0 eventq assignment from resources to
    platform data

 arch/arm/mach-davinci/dm355.c            |    5 +----
 arch/arm/mach-davinci/dm365.c            |    5 +----
 arch/arm/mach-davinci/include/mach/spi.h |   15 ++++++++++-----
 drivers/spi/davinci_spi.c                |   11 +++--------
 4 files changed, 15 insertions(+), 21 deletions(-)
