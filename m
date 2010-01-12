From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jan 2010 17:46:21 -0700
Subject: [PATCH 0/5] Some OMAP clock/SCM patches for 2.6.34
Message-ID: <20100112004326.24684.91321.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these patches have been posted on the linux-omap mailing list and are
part of the planned queue for 2.6.34, but are being posted here in the event
that anyone else wishes to comment.  These patches include clock support for
the Sitara platform (AM35xx) and some minor clock code improvements.

- Paul


---

Paul Walmsley (3):
      OMAP3 clock: reorganize CK_* platform flags
      OMAP clock: make the fixed divisor clock code available for all OMAPs
      OMAP1 clock: convert armwdt_ck to use the fixed divisor recalc function

Ranjith Lohithakshan (2):
      AM35xx: Add AM35xx specific control module registers
      AM35xx: Clock table updates for AM3505/17


 arch/arm/mach-omap1/clock.c                   |    6 
 arch/arm/mach-omap1/clock_data.c              |    3 
 arch/arm/mach-omap2/clock.c                   |   11 -
 arch/arm/mach-omap2/clock.h                   |    1 
 arch/arm/mach-omap2/clock2xxx_data.c          |    4 
 arch/arm/mach-omap2/clock34xx_data.c          |  365 +++++++++++++------------
 arch/arm/plat-omap/clock.c                    |   11 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   26 +-
 arch/arm/plat-omap/include/plat/clock.h       |    3 
 arch/arm/plat-omap/include/plat/control.h     |   17 +
 10 files changed, 237 insertions(+), 210 deletions(-)
