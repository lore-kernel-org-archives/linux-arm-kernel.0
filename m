From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  6 Mar 2015 16:54:48 -0800
Subject: [PATCH 0/5] ARM: Broadcom Brahma-B15 readahead cache support
Message-ID: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for the Broadcom Brahma-B15 CPU read-ahead cache
which is to be found in several Broadcom SoCs, and mainline brcmstb.

Let me know your thoughts on this, we have tried to minimize both the
compile-time and runtime impact for non-Broadcom CPU parts.

Florian Fainelli (5):
  ARM: v7: allow setting different cache functions
  ARM: Add Broadcom Brahma-B15 readahead cache support
  ARM: Hook B15 readahead cache functions based on processor
  ARM: B15: Add CPU hotplug awareness
  ARM: B15: Add suspend/resume hooks

 arch/arm/include/asm/cacheflush.h             |   2 +-
 arch/arm/include/asm/glue-cache.h             |   4 +
 arch/arm/include/asm/hardware/cache-b15-rac.h |  12 +
 arch/arm/mm/Kconfig                           |   8 +
 arch/arm/mm/Makefile                          |   1 +
 arch/arm/mm/cache-b15-rac.c                   | 329 ++++++++++++++++++++++++++
 arch/arm/mm/cache-v7.S                        |  21 ++
 arch/arm/mm/proc-v7.S                         |   6 +-
 8 files changed, 379 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/cache-b15-rac.h
 create mode 100644 arch/arm/mm/cache-b15-rac.c

-- 
2.1.0
