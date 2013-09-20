From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Sep 2013 10:38:09 -0700
Subject: [PATCH 0/4] Clean up legacy platform data handling for omaps for v3.13
Message-ID: <20130920173310.2584.24522.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few patches to make it easier for us to maintain
legacy platform data support while moving to device
tree based booting. It seems that we still have quite a
few places where we still need platform data for omap3
to keep things from breaking.

As the remaining drivers get converted to use device tree,
we can then just remove the support from the pdata-quirks.c.

Regards,

Tony

---

Tony Lindgren (4):
      ARM: OMAP2+: Always build in board-generic
      ARM: OMAP2+: Add quirk support for legacy platform data init
      ARM: OMAP2+: Use pdata quirk support for board-generic.c
      ARM: OMAP2+: Use pdata quirks for wl12xx legacy init


 arch/arm/mach-omap2/Kconfig         |   10 +--
 arch/arm/mach-omap2/Makefile        |    2 -
 arch/arm/mach-omap2/board-generic.c |   33 ----------
 arch/arm/mach-omap2/common.h        |    2 +
 arch/arm/mach-omap2/devices.c       |   38 ------------
 arch/arm/mach-omap2/pdata-quirks.c  |  111 +++++++++++++++++++++++++++++++++++
 6 files changed, 118 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pdata-quirks.c

-- 
Signature
