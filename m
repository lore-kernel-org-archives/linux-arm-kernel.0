From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 29 Jul 2011 16:50:16 +0200
Subject: [PATCH 0/5] Miscellaneous s3c64xx fixes.
Message-ID: <mailman.42.1311955336.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to fix some issues I approached when working
on the s3c64xx platform. See descriptions of individual patches for more
details on each one.

All the patches are based on v3.0 tag of Linus' tree.

Tomasz Figa (5):
  ARM: s3c64xx: PM: Mask and acknowledge all UART interrupts during
    core resume.
  ARM: s3c64xx: DMA: Use S3C64XX_SDMA_SEL register name instead of
    numeric address.
  ARM: s3c64xx: Save/restore S3C64XX_SDMA_SEL on suspend/resume.
  ARM: s3c64xx: Save/restore S3C64XX_MODEM_MIFPCON on suspend/resume to
    preserve LCD bypass state.
  ARM: s3c64xx: Add support for synchronous clock operation.

 arch/arm/mach-s3c64xx/clock.c                   |    8 +++++-
 arch/arm/mach-s3c64xx/dma.c                     |    2 +-
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    4 +++
 arch/arm/mach-s3c64xx/include/mach/regs-sys.h   |    2 +
 arch/arm/mach-s3c64xx/pm.c                      |   30 
+++++++++++++++++++++++
 5 files changed, 44 insertions(+), 2 deletions(-)

-- 
1.7.6
