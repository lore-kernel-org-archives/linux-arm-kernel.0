From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Oct 2014 17:33:07 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a7791: Correct number of CPU cores
Message-ID: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series separates AMPU resource data as it is not
common accross R-Car gen2 SoCs: only the r8a7790 (H1) has the resouces
described. It then corrects the resource data for the r8a7791,
the only other SoC currently present in mainline that uses this data.

Based on the renesas-next-20141024-v3.18-rc1 tag of my renesas tree.

Hisashi Nakamura (2):
  ARM: shmobile: Separate APMU resource data into CPU dependant part
  ARM: shmobile: r8a7791: Correct number of CPU cores

 arch/arm/mach-shmobile/common.h       |  5 -----
 arch/arm/mach-shmobile/platsmp-apmu.c | 27 +++++++++------------------
 arch/arm/mach-shmobile/platsmp-apmu.h | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7790.c  | 16 +++++++++++++++-
 arch/arm/mach-shmobile/smp-r8a7791.c  | 12 +++++++++++-
 5 files changed, 67 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/platsmp-apmu.h

-- 
2.1.1
