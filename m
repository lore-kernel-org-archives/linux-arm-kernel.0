From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 30 Dec 2012 11:28:26 -0700
Subject: [PATCH 0/3] ARM: OMAP2+: PM/hwmod: clean up some WFI-related code
Message-ID: <20121230182745.30526.47072.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements a hwmod flag that can be set on OMAP IP blocks
to indicate that the MPU should not be allowed to enter WFI when the
IP blocks are active.  It also drops what appears to be unnecessary
SRAM code used by the OMAP2xxx PM code, using an inline WFI instead.

- Paul

---

Paul Walmsley (3):
      ARM: OMAP2xxx: PM: enter WFI via inline asm if CORE stays active
      ARM: OMAP2+: hwmod: add support for blocking WFI when a device is active
      ARM: OMAP2420: hwmod data/PM: use hwmod to block WFI when I2C active


 arch/arm/mach-omap2/omap_hwmod.c           |    8 ++++++++
 arch/arm/mach-omap2/omap_hwmod.h           |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
 arch/arm/mach-omap2/pm24xx.c               |   22 +++-------------------
 arch/arm/mach-omap2/sleep24xx.S            |   19 -------------------
 5 files changed, 26 insertions(+), 39 deletions(-)
