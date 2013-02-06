From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Thu,  7 Feb 2013 00:50:47 +0200
Subject: [PATCH v3 0/2] ARM: OMAP2+: Export SoC information to userspace using
 SoC infrastructure
Message-ID: <1360191049-24017-1-git-send-email-ruslan.bilovol@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series is an attempt to export some OMAP SoC
information (like name, revision etc.) to userspace.
The first patch does some unification of OMAP SoC
information representation in current sources.
Second patch adds exactly needed changes using
exists in Linux kernel SoC infrastructure.

-----------------------------------------
v3:
- reduced number of lines changed in the first patch (reusing
  existent code)

-----------------------------------------
v2:
- changed cpu_* -> soc_* variable names
- rebased on top of 'omap-for-v3.9/soc' branch of tmlind/linux-omap tree


Ruslan Bilovol (2):
  ARM: OMAP2+: SoC name and revision unification
  ARM: OMAP2+: Export SoC information to userspace

 arch/arm/mach-omap2/common.h |    8 ++++
 arch/arm/mach-omap2/id.c     |   95 ++++++++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/io.c     |    1 +
 arch/arm/plat-omap/Kconfig   |    1 +
 4 files changed, 97 insertions(+), 8 deletions(-)

-- 
1.7.9.5
