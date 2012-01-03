From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 02 Jan 2012 23:34:21 -0500 (EST)
Subject: Git pull request: shmobile fix for the vmalloc series
Message-ID: <alpine.LFD.2.02.1201022323090.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following into your devel-stable branch:

	git://git.linaro.org/people/nico/linux vmalloc

This contains a patch from Magnus Damm fixing the oversized DMA area 
issue on shmobile, and a revert of the temporary and noisy workaround 
(which is already in your devel-stable branch) that was needed because 
of that issue.

Magnus Damm (1):
      ARM: mach-shmobile: use standard 2MiB coherent DMA memory size

Nicolas Pitre (1):
      Revert "ARM: move VMALLOC_END down temporarily for shmobile"

 arch/arm/include/asm/pgtable.h          |    7 -------
 arch/arm/mach-shmobile/board-ag5evm.c   |    2 --
 arch/arm/mach-shmobile/board-ap4evb.c   |    2 --
 arch/arm/mach-shmobile/board-g3evm.c    |    2 --
 arch/arm/mach-shmobile/board-g4evm.c    |    2 --
 arch/arm/mach-shmobile/board-mackerel.c |    2 --
 6 files changed, 0 insertions(+), 17 deletions(-)


Nicolas
