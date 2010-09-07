From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue,  7 Sep 2010 13:27:17 +0530
Subject: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
Message-ID: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just repost adding Catalin's ack to the patches and
combining Thomas's two rebased kexec patches.
It's generated against the mainline 2.6.36-rc3 + Catalin's
"[PATCH 0/9] Various patches for 2.6.37-rc1" series.

Santosh Shilimkar (4):
  omap4: l2x0: Override the default l2x0_disable
  ARM: l2x0: Fix coding-style in the cache-l2x0.h
  ARM: l2x0: Determine the cache size
  ARM: l2x0: Optimise the range based operations

Thomas Gleixner (2):
  arm: Disable outer (L2) cache in kexec
  arm: Implement l2x0 cache disable functions

 arch/arm/include/asm/hardware/cache-l2x0.h |    9 +++-
 arch/arm/include/asm/outercache.h          |   24 +++++++++++
 arch/arm/kernel/machine_kexec.c            |    3 +
 arch/arm/mach-omap2/omap4-common.c         |   13 ++++++
 arch/arm/mm/cache-l2x0.c                   |   63 ++++++++++++++++++++++++++-
 5 files changed, 106 insertions(+), 6 deletions(-)
