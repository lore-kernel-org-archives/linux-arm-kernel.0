From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 16:20:26 +0200
Subject: [PATCH 0/5] ARM: mvebu: fixes and improvements for 375 support
Message-ID: <1399299631-30825-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

Here are five patches making fixes and improvements to the Armada 375
support. They are related to the fact that we now have access to
Armada 375 A0 boards (however, Ezequiel still only has access to a Z1
platform, so we would like to keep Z1 support for now).

 * Patch 1 is really a fix. It fixes the thermal related quirk that
   was added by Ezequiel, to make sure it really works on A0 revision.

 * Patch 2 to 5 make the SMP and coherency workarounds conditional on
   the Armada 375 Z1. The condition on SMP is really mandatory to get
   SMP working on A0. For coherency, the WA could be used on A0, but
   it is useless and hurt performance.

The series is based on your mvebu/soc branch.

Thanks,

Thomas

Thomas Petazzoni (5):
  ARM: mvebu: fix thermal quirk SoC revision check
  ARM: mvebu: initialize mvebu-soc-id earlier
  ARM: mvebu: add Armada 375 A0 revision definition
  ARM: mvebu: conditionalize Armada 375 SMP workaround
  ARM: mvebu: conditionalize Armada 375 coherency workaround

 arch/arm/mach-mvebu/board-v7.c     |  2 +-
 arch/arm/mach-mvebu/coherency.c    |  9 +++++++--
 arch/arm/mach-mvebu/mvebu-soc-id.c |  2 +-
 arch/arm/mach-mvebu/mvebu-soc-id.h |  1 +
 arch/arm/mach-mvebu/platsmp-a9.c   | 22 +++++++++++-----------
 5 files changed, 21 insertions(+), 15 deletions(-)

-- 
1.9.2
