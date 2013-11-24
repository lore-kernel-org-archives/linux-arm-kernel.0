From: broonie@kernel.org (Mark Brown)
Date: Sun, 24 Nov 2013 14:50:11 +0000
Subject: [GIT PULL] s3c64xx dmaengine conversion
Message-ID: <20131124145011.GA14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/s3c64xx-dmaengine

for you to fetch changes up to 3faecea70b0d6d050e0ae911032ec340341dc389:

  spi: s3c64xx: Always select S3C64XX_PL080 when ARCH_S3C64XX is enabled (2013-11-24 14:38:25 +0000)

----------------------------------------------------------------
ARM: s3c64xx: Convert to dmaengine

This series of commits from Tomasz converting s3c64xx to use dmaengine
rather than the old s3c-dma API missed the v3.13 merge window - Kukjin
said that he'd applied it (which should mean it's OK from a review point
of view) but it didn't make it into -next or a pull request.

Since a s3c64xx based system is one of my primary development platforms
it'd be really helpful if I could merge this into both ASoC and SPI,
I've got some patches for ASoC ready to go converting to use dmaengine
directly which help with multiplatform and there's some other dmaengine
work for SPI in progress too.  I've therefore made this signed tag, it'd
be great if it could be merged into both arm-soc and those two trees.

----------------------------------------------------------------

I'm open to other ideas for doing this, I'd just really like to see the
code building on this go in this cycle so anything that accomplishes
that is good for me.

Tomasz Figa (6):
      spi: s3c64xx: Do not require legacy DMA API in case of S3C64XX
      ARM: s3c64xx: Add support for DMA using generic amba-pl08x driver
      clk: samsung: s3c64xx: Add aliases for DMA clocks
      ARM: s3c64xx: Remove legacy DMA driver
      clk: samsung: s3c64xx: Remove clock aliases of old DMA driver
      spi: s3c64xx: Always select S3C64XX_PL080 when ARCH_S3C64XX is enabled

 arch/arm/Kconfig                         |   1 +
 arch/arm/mach-s3c64xx/Kconfig            |   7 +-
 arch/arm/mach-s3c64xx/Makefile           |   2 +-
 arch/arm/mach-s3c64xx/common.h           |   5 +
 arch/arm/mach-s3c64xx/dma.c              | 762 -------------------------------
 arch/arm/mach-s3c64xx/include/mach/dma.h | 144 ++----
 arch/arm/mach-s3c64xx/pl080.c            | 244 ++++++++++
 arch/arm/plat-samsung/devs.c             |  10 +-
 arch/arm/plat-samsung/dma-ops.c          |   8 +-
 drivers/clk/samsung/clk-s3c64xx.c        |   4 +-
 drivers/spi/Kconfig                      |   2 +-
 11 files changed, 315 insertions(+), 874 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dma.c
 create mode 100644 arch/arm/mach-s3c64xx/pl080.c
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131124/dd159ca0/attachment.sig>
