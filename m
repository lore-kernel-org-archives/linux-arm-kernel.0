From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 21 Aug 2014 10:45:12 +0200
Subject: [PATCH 0/2] ARM: Remove lowmem limit for default CMA region
Message-ID: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Russell King recently noticed that limiting default CMA region only to
low memory on ARM architecture causes serious memory management issues
with machines having a lot of memory (which is mainly available as high
memory). More information can be found the following thread:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/348441/

Those two patches removes this limit letting kernel to put default CMA
region into high memory when this is possible (there is enough high
memory available and architecture specific DMA limit fits).

This should solve strange OOM issues on systems with lots of RAM
(i.e. >1GiB) and large (>256M) CMA area.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Marek Szyprowski (2):
  mm: cma: adjust address limit to avoid hitting low/high memory
    boundary
  ARM: mm: don't limit default CMA region only to low memory

 arch/arm/mm/init.c |  2 +-
 mm/cma.c           | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
1.9.2
