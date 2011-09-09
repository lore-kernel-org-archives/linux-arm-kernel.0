From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 9 Sep 2011 17:17:46 +0800
Subject: [PATCH v4 0/3] consolidate and clean up the arch/arm/mach-mx5/mm-*.c
Message-ID: <1315559869-24838-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch-set work for consolidate and clean up the arch/arm/mach-mx5/mm-*.c

Jason Liu (4):
  ARM: i.MX5/mm: Consolidate arch/arm/mach-mx5/mm-*.c
  ARM: i.MX5/mm: Remove MX51_DEBUG related mapping
  ARM: i.MX5/mm: Consolidate TZIC map code

---
v4: arrage code(mm.c) layout by the sequence:mx50,mx51,mx51

v3: remove the TZIC for i.mx51 TO1 since there is no support for TO1 now.
    add missing static mapping comments for the i.mx53 part
    split the patches to 1) remove DEBUG mapping 2) add TZIC mapping

v2: Remove the MX51_DEBUG related mapping which is conflict with TZIC.
    MX51_DEBUG related mapping is dead code, no-one use it.


Jason Liu (3):
  ARM: i.MX5/mm: Consolidate arch/arm/mach-mx5/mm-*.c
  ARM: i.MX5/mm: Remove MX51_DEBUG related mapping
  ARM: i.MX5/mm: Consolidate TZIC map code

 arch/arm/mach-mx5/Makefile                |    1 -
 arch/arm/mach-mx5/mm-mx50.c               |   72 ---------------------------
 arch/arm/mach-mx5/mm.c                    |   76 ++++++++++++++++++-----------
 arch/arm/plat-mxc/include/mach/hardware.h |    7 ++-
 arch/arm/plat-mxc/include/mach/mx51.h     |   16 +------
 arch/arm/plat-mxc/include/mach/mx53.h     |    1 +
 6 files changed, 55 insertions(+), 118 deletions(-)
 delete mode 100644 arch/arm/mach-mx5/mm-mx50.c

-- 
1.7.4.1
