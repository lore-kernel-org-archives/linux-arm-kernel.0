From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 03 May 2011 15:59:46 -0400 (EDT)
Subject: Git pull request: switch Dove to ARMv7 mode only
Message-ID: <alpine.LFD.2.00.1105031546350.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you pull the following:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

This contains the removal of ARMv6 mode support for Dove.  Because Dove 
can do both ARMv6 and ARMv7, there is no point keeping special support
in ARMv6 mode for it.  This also makes for a diffstat that is in line
with the current theme on ARM.

Konstantin Porotchkin (2):
      ARM: Moving Marvell Dove platform defaults to ARMv7
      ARM: Sync Marvell Dove defconfig with latest kernel

Nicolas Pitre (1):
      ARM: PJ4: remove the ARMv6 compatible cache method entries

 arch/arm/Kconfig                |    2 +-
 arch/arm/boot/compressed/head.S |    6 -----
 arch/arm/configs/dove_defconfig |   12 +----------
 arch/arm/mm/proc-v6.S           |   34 ---------------------------------
 4 files changed, 2 insertions(+), 52 deletions(-)
