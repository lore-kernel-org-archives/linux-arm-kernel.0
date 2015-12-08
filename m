From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 7 Dec 2015 19:13:06 -0800
Subject: [GIT PULL] MTD/NAND cleanups for v4.5
Message-ID: <20151208031306.GP120110@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Per discussion with Arnd, I plan to pull these into the MTD tree for
4.5, but you should probably have them too.

Full series posted here:

http://lists.infradead.org/pipermail/linux-mtd/2015-December/063828.html

FYI, I got Arnd's 'ack' to take this one solely via MTD, since it's
unlikely to get conflicts:

http://lists.infradead.org/pipermail/linux-mtd/2015-December/063840.html

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mtd.git tags/arm-soc/for-4.5/cleanup

for you to fetch changes up to c993e09504fca192bac4ac3f5a3411ac68cba2e6:

  ARM: nand: make use of mtd_to_nand() where appropriate (2015-12-07 18:58:20 -0800)

----------------------------------------------------------------
Two changes for NAND/MTD refactoring. The mtd_to_nand() helper will allow us to
stop using mtd->priv for NAND drivers.

----------------------------------------------------------------
Boris BREZILLON (2):
      mtd: nand: add an mtd_to_nand() helper
      ARM: nand: make use of mtd_to_nand() where appropriate

 arch/arm/mach-ep93xx/snappercl15.c   | 4 ++--
 arch/arm/mach-ep93xx/ts72xx.c        | 4 ++--
 arch/arm/mach-imx/mach-qong.c        | 2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c | 2 +-
 arch/arm/mach-omap1/board-nand.c     | 2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c | 6 +++---
 arch/arm/mach-pxa/balloon3.c         | 2 +-
 arch/arm/mach-pxa/em-x270.c          | 2 +-
 arch/arm/mach-pxa/palmtx.c           | 2 +-
 include/linux/mtd/nand.h             | 5 +++++
 10 files changed, 18 insertions(+), 13 deletions(-)
