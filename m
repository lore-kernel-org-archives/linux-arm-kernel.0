From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 7 Mar 2010 22:58:59 +0000
Subject: [PULL] please pull bjdooks' for-rmk/samsung6
Message-ID: <20100307225859.GA28823@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this pull fixes the merge problems and bugs found during testing as well
as fixing the s3c2443 clock code to use the common samsung clock code.

The following changes since commit d608c738bb8fb37e5fbfcdef9c566764f2fea086:
  Mark Brown (1):
        ARM: S3C64XX: Add initial support for board specific IRQs

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/samsung6

Ben Dooks (8):
      ARM: S3C2443: Use common clock gate code
      ARM: S3C2440: Fix plat-s3c24xx move of s3c2440/s3c2442 support
      ARM: S3C2443: Change to using plat-samsung clksrc-clk implementation
      ARM: S3C2443: Further clksrc-clk conversions
      ARM: S3C2443: Update notes on MPLLREF clock
      ARM: S3C2443: Remove #if 0 for clk_mpll
      ARM: S3C2443: Add set_rate and round_rate calls for armdiv clock
      ARM: Merge next-samsung-s3c2443-clock

Mark Brown (3):
      ASoC: Fix S3C64xx IIS driver for Samsung header reorg
      ARM: S3C64XX: Reintroduce unconditional build of audio device
      USB: Fix s3c-hsotg build following Samsung platform header moves

 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |   32 +-
 .../s3c2440-pll-12000000.c                         |    2 +-
 .../s3c2440-pll-16934400.c                         |    2 +-
 arch/arm/mach-s3c2443/Kconfig                      |    1 +
 arch/arm/mach-s3c2443/clock.c                      |  817 +++++++-------------
 arch/arm/mach-s3c64xx/Makefile                     |    2 +-
 drivers/usb/gadget/s3c-hsotg.c                     |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                    |    4 +-
 8 files changed, 267 insertions(+), 595 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c2440-pll-12000000.c (98%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c2440-pll-16934400.c (99%)


-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
