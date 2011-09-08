From: jason.hui@linaro.org (Jason Liu)
Date: Thu, 8 Sep 2011 11:27:23 +0800
Subject: [PATCH v3 0/4] Consolidate and clean up the arch/arm/mach-mx5/mm-*.c
Message-ID: <1315452447-20205-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch-set work for consolidate and clean up the arch/arm/mach-mx5/mm-*.c

Jason Liu (4):
  ARM: i.MX5/mm: Consolidate arch/arm/mach-mx5/mm-*.c
  ARM: i.MX5/mm: Remove MX51_DEBUG related mapping
  ARM: i.MX5/mm: add the TZIC mapping resource
  ARM: i.MX5/mm: use static mapping for TZIC

---
v3: remove the TZIC for i.mx51 TO1 since there is no support for TO1 now.
    add missing static mapping comments for the i.mx53 part
    split the patches to 1) remove DEBUG mapping 2) add TZIC mapping

v2: Remove the MX51_DEBUG related mapping which is conflict with TZIC.
    MX51_DEBUG related mapping is dead code, no-one use it.

Jason Liu (4):
  ARM: i.MX5/mm: Consolidate arch/arm/mach-mx5/mm-*.c
  ARM: i.MX5/mm: Remove MX51_DEBUG related mapping
  ARM: i.MX5/mm: add the TZIC mapping resource
  ARM: i.MX5/mm: consolidate TZIC map code

 arch/arm/mach-mx5/Makefile                |    1 -
 arch/arm/mach-mx5/mm-mx50.c               |   72 -----------------------------
 arch/arm/mach-mx5/mm.c                    |   67 ++++++++++++++++++---------
 arch/arm/plat-mxc/include/mach/hardware.h |    7 ++-
 arch/arm/plat-mxc/include/mach/mx51.h     |   16 +------
 arch/arm/plat-mxc/include/mach/mx53.h     |    1 +
 6 files changed, 53 insertions(+), 111 deletions(-)
 delete mode 100644 arch/arm/mach-mx5/mm-mx50.c

-- 
1.7.4.1
