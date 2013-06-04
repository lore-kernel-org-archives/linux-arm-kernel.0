From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 14:44:22 +0200
Subject: Fwd: [GIT PULL 1/5]: ux500 core changes for v3.11
In-Reply-To: <CACRpkdZLQa9_2m6WUYWaBty0F4a13zJA+tnPJZrWYBOeZ=vfrg@mail.gmail.com>
References: <CACRpkdZLQa9_2m6WUYWaBty0F4a13zJA+tnPJZrWYBOeZ=vfrg@mail.gmail.com>
Message-ID: <CACRpkdaLo8xto0o9ngvBsZZpn8Suues+Oy82Wy1Hiye4mF=MEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[It seems I slipped on the keys and  CC:ed this to LKML instead of LAKML.]

Hi ARM SoC folks,

this is the ux500 core changes for v3.11. See the signed
tag for details.

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-for-arm-soc

for you to fetch changes up to 080e0435e54298992dfc03dc04ca53cfe3de36ba:

  ARM: ux500: avoid warning in ux500_read_asicid (2013-06-04 11:21:58 +0200)

----------------------------------------------------------------
Ux500 core changes:
- Fixes for size and location of PRCMU TCDM
- SD/MMC/SDIO caps updates to boardfiles
- Misc fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: ux500: avoid warning in ux500_read_asicid

Lee Jones (3):
      ARM: ux500: Increase the size of the PRCMU's TCPM size
      ARM: ux500: Remove incorrect DB9540 PRCMU TCDM base location
      ARM: ux500: regulators: Remove misleading comment

Ulf Hansson (6):
      ARM: ux500: Enable 100MHz for SD/SDIO/MMC devices
      ARM: ux500: Don't set plf ocr mask for SD/MMC device
      ARM: ux500: Enable support for RPMB and Reliable Write for eMMC
      ARM: ux500: Enable support for discard for MMC/SD
      ARM: ux500: Set eMMC and WLAN card slot as non-removable
      ARM: ux500: Enable support for UHS-I SD-cards

 arch/arm/mach-ux500/board-mop500-regulators.c |  1 -
 arch/arm/mach-ux500/board-mop500-sdi.c        | 34 +++++++++++++++++----------
 arch/arm/mach-ux500/db8500-regs.h             |  3 +--
 arch/arm/mach-ux500/devices-db8500.c          |  2 +-
 arch/arm/mach-ux500/id.c                      |  6 ++---
 5 files changed, 27 insertions(+), 19 deletions(-)
