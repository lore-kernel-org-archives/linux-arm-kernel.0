From: anders.berg@lsi.com (Anders Berg)
Date: Mon, 24 Mar 2014 22:02:11 +0100
Subject: [PATCH RFC] ARM: mm: Fix for highmem on machines with more than 14
 cores
Message-ID: <cover.1395692531.git.anders.berg@lsi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While working of platform support for the LSI AXM5516 SoC (a 16 x A15 device)
we ran into this limitation in fixmap.h where there is not enough room for the
per-cpu pages if NR_CPUS is set to 16.

The following patch avoids the overlap by lowering the base address according to
the values of NR_CPUS and KM_TYPE_NR. Is this the way to handle this?

Thanks,
Anders


Anders Berg (1):
  ARM: mm: Fix for highmem on machines with more than 14 cores

 arch/arm/include/asm/fixmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.3.2
