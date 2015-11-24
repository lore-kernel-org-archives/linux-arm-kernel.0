From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 23 Nov 2015 16:05:53 -0800
Subject: [PATCH v2 0/2] restrict /dev/mem to idle io memory ranges
Message-ID: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1 [1]:

1/ Introduce ARCH_HAS_DEVMEM_IS_ALLOWED to flag archs where
   CONFIG_STRICT_DEVMEM will compile (Ingo)

2/ Drop "default y" for s390 (Heiko)

3/ Fix iomem_is_exclusive() return value in the
   CONFIG_IO_STRICT_DEVMEM=y case.

[1]: https://lkml.org/lkml/2015/11/21/183

---

Dan Williams (2):
      arch: consolidate CONFIG_STRICT_DEVM in lib/Kconfig.debug
      restrict /dev/mem to idle io memory ranges


 arch/arm/Kconfig             |    1 +
 arch/arm/Kconfig.debug       |   14 --------------
 arch/arm64/Kconfig           |    1 +
 arch/arm64/Kconfig.debug     |   14 --------------
 arch/frv/Kconfig             |    1 +
 arch/m32r/Kconfig            |    1 +
 arch/powerpc/Kconfig         |    1 +
 arch/powerpc/Kconfig.debug   |   12 ------------
 arch/s390/Kconfig            |    1 +
 arch/s390/Kconfig.debug      |   12 ------------
 arch/tile/Kconfig            |    4 +---
 arch/unicore32/Kconfig       |    1 +
 arch/unicore32/Kconfig.debug |   14 --------------
 arch/x86/Kconfig             |    1 +
 arch/x86/Kconfig.debug       |   17 -----------------
 kernel/resource.c            |   11 +++++++++--
 lib/Kconfig.debug            |   39 +++++++++++++++++++++++++++++++++++++++
 17 files changed, 57 insertions(+), 88 deletions(-)
