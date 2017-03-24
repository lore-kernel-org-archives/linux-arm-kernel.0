From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:58:01 -0700
Subject: [GIT PULL 1/7] Broadcom soc changes for 4.12
Message-ID: <20170324175807.27272-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/soc

for you to fetch changes up to d47b51ad31e21ab8129da64d42e2fc48e7a215eb:

  ARM: brcmstb: Add entry for 7260 (2017-03-15 14:57:50 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Kconfig/platform changes for
4.12, please pull the following:

- Al enables ZONE_DMA for BRCMSTB platforms since a bunch of on-chip
  peripherals such as USB (OHCI and EHCI) and SDHCI cannot support physical
  addresses > 32-bit. This is only required when ARM_LPAE is enabled

- Danesh enables ARCH_HAS_HOLES_MEMORYMODEL in order for the kernel to provide
  a pfn_valid() implementation despite BRCMSTB enabling the SPARSEMEM model by
  default.

- Florian adds support for a new 28nm generation chip: 7260 by updating the
  runtime detection UART debuggin stub used for DEBUG_LL.

----------------------------------------------------------------
Al Cooper (1):
      ARM: brcmstb: Enable ZONE_DMA for non 64-bit capable peripherals

Danesh Petigara (1):
      ARM: brcmstb: Enable ARCH_HAS_HOLES_MEMORYMODEL

Florian Fainelli (1):
      ARM: brcmstb: Add entry for 7260

 arch/arm/include/debug/brcmstb.S | 18 ++++++++++--------
 arch/arm/mach-bcm/Kconfig        |  2 ++
 2 files changed, 12 insertions(+), 8 deletions(-)
