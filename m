From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Sep 2018 12:27:08 -0700
Subject: [PATCH 0/3] ARM/PSCI: Fix THUMB2_KERNEL entry points
Message-ID: <20180927192711.26455-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

While playing with THUMB2_KERNEL on ARCH_BRCMSTB, several issues came up
which are addressed by these 3 patches.

The THUMB() assembler macro is a no-op unless CONFIG_THUMB2_KERNEL so
using it unconditionally for CONFIG_ARM should not cause a problem
AFAICT.

Those patches can all be independently picked up by their respective
maintainers and don't depent on one another.

Thank you!

Florian Fainelli (3):
  firmware/psci: Fix cpu_resume entry points with THUMB2_KERNEL
  ARM: psci: Fix secondary core boot with THUMB2_KERNEL
  soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL

 arch/arm/kernel/psci_smp.c          |  4 ++--
 drivers/firmware/psci.c             | 18 +++++++++++++++---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.17.1
