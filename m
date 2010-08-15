From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 15 Aug 2010 15:02:11 +0200
Subject: [PATCH 0/3] ARM: S3C64XX: (S)DMA related patches
Message-ID: <4c67e6ab.887b0e0a.53f9.23bc@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the SDMA channels support in the S3C64XX SoC. The
main user of this is the not-yet-submitted Samsung crypto driver.

Additionally, it fixes an issue with the DMA core not stopping and flushing the
requests when the channel is freed.

Maurus Cuelenaere (3):
  ARM: S3C64XX: Add SDMA clocks
  ARM: S3C64XX: Add SDMA support to DMA core
  ARM: S3C64XX: Stop and flush requests on freeing

 arch/arm/mach-s3c64xx/clock.c |   12 +++++++++
 arch/arm/mach-s3c64xx/dma.c   |   54 ++++++++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 11 deletions(-)
