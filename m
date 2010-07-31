From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 31 Jul 2010 23:13:46 +0530
Subject: [PATCH 0/4] ARM: l2x0: Optimisation and minor cleanup
Message-ID: <1280598226-4317-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is generated against latest mainline + Thomas's
earlier kexec series.
	http://www.spinics.net/lists/arm-kernel/msg92095.html
	
[PATCH 1/4] ARM: l2x0: Fix coding-style in the cache-l2x0.h
	- Small clean up in cache-l2x0.h
[PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
	- Override the generic l2x0_disable with omap4 specific fn
[PATCH 3/4] ARM: l2x0: Determine the cache size
	- Calculate the total L2 cache size
[PATCH 4/4] ARM: l2x0: Optmise the range based operations
	- Speedup cache operations for bigger buffers	
	
Santosh Shilimkar (4):
  ARM: l2x0: Fix coding-style in the cache-l2x0.h
  omap4: l2x0: Override the default l2x0_disable
  ARM: l2x0: Determine the cache size
  ARM: l2x0: Optmise the range based operations

 arch/arm/include/asm/hardware/cache-l2x0.h |    9 ++-
 arch/arm/mach-omap2/omap4-common.c         |   13 ++++
 arch/arm/mm/cache-l2x0.c                   |  108 ++++++++++++++++++----------
 3 files changed, 88 insertions(+), 42 deletions(-)
