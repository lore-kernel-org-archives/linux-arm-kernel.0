From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Nov 2009 16:43:13 +0000
Subject: [PATCH 0/7] S3C64XX IISv4 support
Message-ID: <20091127164312.GA11913@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the arch/arm changes required to support the
IISv4 block on the S3C6410 CPU, plus providing hookup for the block on
the SMDK6410.  I know it's a bit late but it'd be great if we could get
this into 2.6.33 - it'd be *very* handy for ASoC development.

Jassi (1):
      S3C64XX: Declare IISv4 PCLK for S3C6410

Mark Brown (6):
      S3C64XX: Staticise platform data for PCM devices
      S3C6410: Correct names of IISv4 data output pin definitions
      S3C64XX: Add support for CLK_SRC2 configured clocks
      S3C6410: Define CLK_AUDIO2 for IISv4 block
      S3C6410: Use platform data to supply pin configuration for IISv4
      SMDK6410: Register IISv4 device

 arch/arm/mach-s3c6410/mach-smdk6410.c            |    1 +
 arch/arm/plat-s3c64xx/clock.c                    |    8 +++
 arch/arm/plat-s3c64xx/dev-audio.c                |   26 ++++++++-
 arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h |    6 +-
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h  |    4 ++
 arch/arm/plat-s3c64xx/s3c6400-clock.c            |   64 +++++++++++++++++++++-
 6 files changed, 101 insertions(+), 8 deletions(-)
