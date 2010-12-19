From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 19 Dec 2010 14:30:47 -0500 (EST)
Subject: Git pull request: map_atomic fixes for v2.6.37-rc6
Message-ID: <alpine.LFD.2.00.1012191307550.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull:

	git://git.linaro.org/people/nico/linux kmap_atomic_fixes

This contains fixes for correctness issues introduced by the stack based 
kmap_atomic changes that were merged during this cycle.  Those patches 
have been posted to the list earlier this week.

Nicolas Pitre (3):
      ARM: get rid of kmap_high_l1_vipt()
      ARM: fix cache-xsc3l2 after stack based kmap_atomic()
      ARM: fix cache-feroceon-l2 after stack based kmap_atomic()

 arch/arm/include/asm/highmem.h  |    3 -
 arch/arm/mm/cache-feroceon-l2.c |   37 +++++++-------
 arch/arm/mm/cache-xsc3l2.c      |   57 ++++++++--------------
 arch/arm/mm/dma-mapping.c       |    7 ++-
 arch/arm/mm/flush.c             |    7 ++-
 arch/arm/mm/highmem.c           |   87 ---------------------------------
 6 files changed, 48 insertions(+), 150 deletions(-)


Nicolas
