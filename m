From: ccross@android.com (Colin Cross)
Date: Sun,  1 May 2011 14:10:09 -0700
Subject: [PATCH 0/4] Tegra irq cleanups
Message-ID: <1304284213-11950-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up the Tegra irq subsystem, and allows
the GIC to be switched to the fasteoi handler.  The first three
patches have no dependencies on any other trees.  Patch 4 should
only go in at the same time as Will Deacon's fasteoi patches,
and could be squashed into his patch.

As part of this series, power management support is removed from
the Tegra irq subsystem.  PM support will be added back in a
future patch set along with PM support for the rest of the
platform.

Colin Cross (4):
      ARM: tegra: irq: convert to gic arch extensions
      ARM: tegra: irq: Remove PM support
      ARM: tegra: irq: Move legacy_irq.c into irq.c
      ARM: tegra: irq: Replace tegra_ack with tegra_eoi

 arch/arm/mach-tegra/Makefile                  |    2 +-
 arch/arm/mach-tegra/include/mach/legacy_irq.h |   35 ----
 arch/arm/mach-tegra/irq.c                     |  181 +++++++++------------
 arch/arm/mach-tegra/legacy_irq.c              |  215 -------------------------
 4 files changed, 77 insertions(+), 356 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/legacy_irq.h
 delete mode 100644 arch/arm/mach-tegra/legacy_irq.c
